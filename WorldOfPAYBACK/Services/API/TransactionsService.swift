//
//  TransactionsService.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 22/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import Foundation
import Combine

fileprivate let CLASS_ID: String = "[TransactionsService]"

///Receives a data by ``NetworkManager`` like an `[TransactionResponse]`
///
/// Request URL for different environment:
/// - PROD / https://api.payback.com/transactions/
/// - TEST / https://api-test.payback.com/transactions
///
/// - Note: Initialized in ``TransactionViewModel``
final class TransactionsService {
    
    @Published var transactions: [TransactionItem] = []
    
    private var dataCancellable: AnyCancellable?
    
    init() { Task { await getTransactions() } }
    
    /// Fetches transactions data from a remote server.
    ///
    /// This method asynchronously retrieves transactions data from a specified `URL`.
    /// It utilizes `NetworkManager` to download the data, decode it into a `TransactionResponse` object using `JSONDecoder`,
    /// and updates the transactions property accordingly.
    /// Upon completion, it cancels the dataCancellable subscription and logs the fetched transactions for debugging purposes.
    private func getTransactions() async {
        guard let url = URL(string: Networks.URLs.getTransactionsData()) else { return }
        
        dataCancellable = NetworkManager.downloadData(with: url)
            .decode(type: TransactionResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion(completion:),
                  receiveValue: { [weak self] dataResponse in
                guard let self else { return }
                
                transactions = dataResponse.items
                debugPrint("\(CLASS_ID) / TRANSACTIONS / \(transactions) ✅")
                
                dataCancellable?.cancel()
            })
    }
    
    //MARK: - DEINIT SETUP 🧨
    deinit { debugPrint("DEINIT - \(CLASS_ID) 💥"); dataCancellable?.cancel() }
}
