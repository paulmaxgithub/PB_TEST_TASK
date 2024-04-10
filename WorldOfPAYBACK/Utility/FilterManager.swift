//
//  FilterManager.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

/// Manages filtering of transaction items based on selected categories.
///
/// This struct provides a static method `filterTransactions` which takes a set of selected category IDs and an array of transaction items as input.
/// It filters the transaction items based on the selected categories, returning a new array containing only those items whose category matches one of the selected categories.
///
/// - Parameters:
///   - category: A set containing the IDs of selected categories.
///   - transactions: An array of transaction items to be filtered.
///
/// - Returns: An array of transaction items filtered based on the selected categories.
///
struct FilterManager {
    
    static func filterTransactions(selected category: Set<Int>, _ transactions: [TransactionItem]) -> [TransactionItem] {
        
        guard category.isEmpty == false else { return transactions }
        
        return transactions.filter { item in
            return category.contains(item.category)
        }
    }
}
