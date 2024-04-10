//
//  SortingManager.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

import Foundation

/// SortingManager provides a centralized interface for sorting transaction items based on different criteria.
///
/// - Parameters:
///     - `sort`: An enum representing the sorting option. Currently, only supports sorting by date.
///     - `transactions`: An inout array of TransactionItem instances to be sorted. The array will be modified in place.
///
/// Usage:
///
///     SortingManager.sortTransactions(sortedBy: .date, transactions: &transactionItems)
///
struct SortingManager {
    
    /// Enum representing the sorting options available.
    enum SortOption { case date }
    
    /// Sorts the provided transaction items based on the specified sorting option.
    ///
    /// - Parameters:
    ///     - `sort`: An enum representing the sorting option. Currently, only supports sorting by date.
    ///     - `transactions`: An inout array of TransactionItem instances to be sorted. The array will be modified in place.
    ///
    static func sortTransactions(sortedBy sort: SortOption, transactions: inout [TransactionItem]) {
        switch sort {
        case .date:
            transactions.sort(by: { $0.transactionDetail.date ?? Date() > $1.transactionDetail.date ?? Date() })
        }
    }
}
