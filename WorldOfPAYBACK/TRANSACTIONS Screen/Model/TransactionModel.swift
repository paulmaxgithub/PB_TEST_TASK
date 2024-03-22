//
//  TransactionModel.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import Foundation

/// Represents a response object containing transaction data.
///
/// This struct is used to decode JSON responses from the server into Swift objects representing transactions.
/// It contains an array of `TransactionItem` objects, each representing a single transaction entry.
///
///     {
///         "items" : [
///             {
///                 "partnerDisplayName" : "REWE Group",
///                 "alias" : {
///                     "reference" : "795357452000810"
///                 },
///                 "category" : 1,
///                 "transactionDetail" : {
///                     "description" : "Punkte sammeln",
///                     "bookingDate" : "2022-07-24T10:59:05+0200",
///                     "value" : {
///                         "amount" : 124,
///                         "currency" : "PBP"
///                     }
///                 }
///            }, ...
///
struct TransactionResponse: Decodable {
    let items: [TransactionItem]
}

struct TransactionItem: Decodable, Identifiable {
    let partnerDisplayName: String
    let alias:              Alias
    let category:           Int
    let transactionDetail:  TransactionDetail
    
    /// Coding keys for decoding from `JSON`.
    enum CodingKeys: String, CodingKey { case partnerDisplayName, alias, category, transactionDetail }
    
    var id = UUID().uuidString
}

struct Alias: Codable {
    let reference: String
}

struct TransactionDetail: Codable {
    let description:    String?
    let bookingDate:    String
    let value:          Value
    
    var date: Date? { bookingDate.toDate() }
}

struct Value: Codable {
    let amount:     Int
    let currency:   String
}
