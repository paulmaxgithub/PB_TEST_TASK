//
//  JSON_MockDataService.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import Foundation
import Combine

fileprivate let CLASS_ID: String = "[JSON_MockDataService]"

/// A class responsible for fetching transactions data.
///
/// This class provides a method `fetchTransactions()` to simulate the process of fetching transaction data.
/// It utilizes a JSON mock data manager to fetch JSON data, simulating loading with a random delay.
/// The method then decodes the fetched data into a `TransactionResponse` model using Combine framework's publishers.
/// Upon successful completion, the fetched transactions are sent through a Combine subject, indicating a successful load.
/// If an error occurs during the process, the failure is also handled and reported accordingly.
///
final class JSON_MockDataService {
    
    /// Represents the result of a transaction completion, indicating whether the transaction was successfully loaded with a `TransactionResponse` or if it failed.
    /// This enum encapsulates the possible outcomes of a transaction completion, providing a clear and concise way to handle different scenarios during transaction processing.
    /// It offers two cases: `loaded`, indicating a successful transaction with associated `TransactionResponse` data, and `failed`, indicating a transaction failure.
    enum TransactionCompletionResult { case loaded(TransactionResponse), failed }
    
    /// - Use `PassthroughSubject' to manually retrieve data from the `TransactionViewModel'
    ///
    private let subject = PassthroughSubject<TransactionCompletionResult, Never>()
    public var dataPublisher: AnyPublisher<TransactionCompletionResult, Never> {
        return subject.eraseToAnyPublisher()
    }
    
    //MARK: SERVICES
    private var dataCancellable: AnyCancellable?
    
    //MARK: - PUBLIC
    
    /// Fetches transactions data.
    ///
    /// This function simulates the process of fetching transactions data.
    /// It utilizes a JSON mock data manager to fetch JSON data, simulating loading with a random delay.
    /// Upon completion, the fetched transactions are sent through a Combine subject, indicating a successful load.
    /// If an error occurs during the process, the failure is handled and reported accordingly.
    public func fetchTransactions() {
        
        let dataFromJSON = JSON_MockDataManager.fetchJSONData()
        
        let shouldFail = Bool.random()
        
        ///SImaulate Loading ⚙️
        DispatchQueue.global().asyncAfter(deadline: .now() + Double.random(in: 1...2)) { [weak self] in
            
            guard let self else { return }
            
            if shouldFail { subject.send(.failed) }
            else {
                dataCancellable = dataFromJSON
                    .flatMap { data in
                        Just(data)
                            .decode(type: TransactionResponse.self, decoder: JSONDecoder())
                            .eraseToAnyPublisher()
                    }
                    .sink { completion in
                        switch completion {
                        case .finished:             debugPrint("\(CLASS_ID) - Completion has finished... ✅")
                        case .failure(let error):   debugPrint("\(CLASS_ID) - Completion with an \(error) ⚠️")
                        }
                    } receiveValue: { [weak self] value in
                        guard let self else { return }
                        subject.send(.loaded(value))
                        debugPrint("\(CLASS_ID) - Value has been received... ✅")
                    }
            }
        }
    }
    
    //MARK: - PRIVATE
    
    /// Decodes JSON data into a specified type conforming to the Decodable protocol.
    ///
    /// This method takes a Data instance containing JSON-encoded data and a type representing the structure into which the JSON data should be decoded.
    /// It returns a publisher that emits the decoded value or an error if decoding fails.
    ///
    /// - Parameters:
    ///   - data: The JSON data to decode.
    ///   - type: The type of the object into which the JSON data should be decoded.
    /// - Returns: A publisher emitting the decoded value or an error.
    ///
    private func decodeJSON<T: Decodable>(data: Data, as type: T.Type) -> AnyPublisher<T, Error> {
        return Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    //MARK: - DEINIT SETUP 🧨
    deinit { debugPrint("DEINIT - \(CLASS_ID) 💥"); dataCancellable?.cancel() }
}
