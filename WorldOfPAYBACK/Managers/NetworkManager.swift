//
//  NetworkManager.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 22/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import Foundation
import Combine

fileprivate let CLASS_ID: String = "[NetworkManager]"

/// Retrieves the data and passes it to the ``JSON_MockDataService``.
/// * Just assume that the Backend is not ready yet and the App needs to work with mocked data meanwhile.
/// * For now, the Backend-Team has just provided the name of the endpoints for the new Service:
/// * Production Environment: "GET https://api.payback.com/transactions"
/// * Test Environment: "GET https://api-test.payback.com/transactions"
final class NetworkManager {
    
    // Use URLSession with a custom delegate configured to allow insecure connections
    static private let configuration = URLSessionConfiguration.default
    static private let delegate = InsecureURLSessionDelegate()
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL), unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "\(CLASS_ID) / [💥] Bad Response From URL \(url)"
            case .unknown:
                return "\(CLASS_ID) [⚠️] Unknown Error occured"
            }
        }
    }
    
    //MARK: PUBLIC
    public static func downloadData(with url: URL) -> AnyPublisher<Data, Error> {
        
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        return session.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0) }
            .eraseToAnyPublisher()
    }
    
    public static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):   debugPrint("\(CLASS_ID) / ⚠️ \(error)")
        case .finished:             debugPrint("\(CLASS_ID) / Completion is .finished ✅"); return
        }
    }
    
    //MARK: PRIVATE
    private static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            debugPrint("\(CLASS_ID) / STATUS_CODE - " + ((output.response as? HTTPURLResponse)?.statusCode.description ?? ""))
            throw NetworkingError.badURLResponse(url: output.response.url!)
        }
        return output.data
    }
}

//MARK: - Define a custom URLSessionDelegate to handle certificate validation

/// - 1. Implement the URLSessionDelegate method to allow insecure connections
/// - 2. Check if the challenge is related to server trust
/// - 3. Allow the connection regardless of the server's certificate validity
fileprivate class InsecureURLSessionDelegate: NSObject, URLSessionDelegate {
    // 1.
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // 2.
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            
            // 3.
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }
    }
}
