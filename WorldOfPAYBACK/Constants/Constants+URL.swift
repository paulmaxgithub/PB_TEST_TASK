//
//  Constants+URL.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

//MARK: * Production Environment:   GET "https://api.payback.com/transactions/"
//MARK: * Test Environment:         GET "https://api-test.payback.com/transactions"

//TODO: CHANGE THE CURRENT STATE OF DEVELOPMENT ⚠️
public let isPROD: Bool = false

fileprivate let prodHost: String = "https://api.payback.com/"
fileprivate let testHost: String = "https://api-test.payback.com/"

/// Manages the configuration of host URLs for different environments.
/// `prodHost` and `testHost`, which represent the base URLs for the production and test environments respectively.
/// These URLs are used to construct the endpoint URLs for API requests in their respective environments.
fileprivate let HOST: String = (isPROD) ? prodHost : testHost

//MARK: 1️⃣ TRANSACTIONS
/// Defines the base path for transaction-related endpoints.
/// This constant represents the base path for transaction-related endpoints in the application's network requests.
/// It provides a centralized location for managing the URL path, promoting consistency and ease of maintenance.
fileprivate let transaction: String = "transactions/"

/// `Networks` struct provides a centralized interface for defining and accessing network-related configurations and endpoints.
/// It encapsulates the definitions of URLs and endpoint paths, facilitating the organization and management of network-related constants.
///
/// Example Usage:
///
///      let transactionsURL = Networks.URLs.getTransactionsData()
///
struct Networks {
    
    enum URLs {
        
        // TRANSACTIONS
        static func getTransactionsData() -> String { HOST + transaction }
    }
}
