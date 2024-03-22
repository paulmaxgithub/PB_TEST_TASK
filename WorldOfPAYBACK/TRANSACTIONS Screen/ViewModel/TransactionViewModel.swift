//
//  TransactionViewModel.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import Foundation
import Combine

fileprivate let CLASS_ID: String = "[TransactionViewModel]"

final class TransactionViewModel: ObservableObject {
    
    //MARK: States & Data
    @Published public var transactions:         [TransactionItem] = []
    @Published public var categories:           [Int] = []
    @Published public var selectedCategories:   Set<Int> = []
    @Published public var isDataLoading:        Bool = false
    @Published public var showAlert:            Bool = false
    @Published public var currencyAmount:       Decimal = 0.0
    @Published public var selectedItem:         TransactionItem? = nil
    @Published public var sortOption:           SortingManager.SortOption = .date
    
    //MARK: Services
    ///Service to get mock data. Use it for startup development
    private let JSON_Service        = JSON_MockDataService()
    
    ///Use this service to verify API accessibility in `CONSOLE`
    ///This parameter is not used in ⚠️
    private let transactionsService = TransactionsService()
    
    private var dataCancellables    = Set<AnyCancellable>()
    
    //MARK: INIT SETUP
    init() {
        subscriptionsSetup()
        loadTransactionData()
    }
    
    //MARK: Subscription Setup
    private func subscriptionsSetup() {
        
        /// Updates transaction data based on selected categories and sorting options.
        /// This code snippet subscribes to a `dataPublisher` and updates the UI with filtered and sorted transactions.
        /// It also fetches categories if they are empty.
        JSON_Service.dataPublisher
            .receive(on: DispatchQueue.main)
            .map(mapTransactionItems)
            .combineLatest($selectedCategories, $sortOption)
            .map(filterAndSortTransactions)
            .sink { [unowned self] in
                if $0.isEmpty == false {
                    transactions = $0
                    getCurrencyAmount($0)
                    isDataLoading = false
                }
                
                /// Fetch `categories` only once
                if categories.isEmpty { getCategories($0) }
            }
            .store(in: &dataCancellables)
    }
    
    //MARK: - PUBLIC
    
    /// `Load` || `Reload` data
    /// Used by tapping the button in ``TransactionItem`` / `.alert(...)`
    public func loadTransactionData() {
        isDataLoading = true
        JSON_Service.fetchTransactions()
    }
    
    /// Reset selected categories.
    /// Used by tapping the button in ``CategorySectionView``
    public func resetSelectedCategories() {
        selectedCategories = []
    }
    
    //MARK: - PRIVATE
    
    /// Retrieves unique categories from the provided array of `TransactionItem` objects.
    ///
    /// This method iterates through the given array of `TransactionItem` objects and extracts unique category identifiers.
    /// It populates the `categories` property with the sorted array of unique category identifiers.
    ///
    /// - Parameter items: An array of `TransactionItem` objects from which to extract categories.
    ///
    private func getCategories(_ items: [TransactionItem]) {
        var categorySet = Set<Int>()
        
        items.forEach { categorySet.insert($0.category) }
        
        categories = Array(categorySet).sorted()
    }
    
    /// Maps transaction items from a given result obtained from a ``JSON_MockDataService()``
    ///
    /// This method processes the result obtained from the JSON mock data service, either .failed or .loaded.
    /// If the result is .failed, it sets the '`sDataLoading` flag to false, displays an alert message, and logs a debug message indicating loading failure.
    /// If the result is .loaded, it extracts the transaction items from the response and returns them.
    ///
    /// - Parameter result: The result obtained from the JSON mock data service, representing the completion state of the transaction loading process.
    /// - Returns: An array of `TransactionItem` objects extracted from the provided result.
    ///
    private func mapTransactionItems(from result: JSON_MockDataService.TransactionCompletionResult) -> [TransactionItem] {
        var items: [TransactionItem] = []
        
        switch result {
        case .failed:
            isDataLoading = false
            showAlertMessage()
            debugPrint("\(CLASS_ID) - LOADING FAILED!!! ⚠️")
        case .loaded(let response):
            items = response.items
        }
        return items
    }
    
    /// Filters and sorts a collection of transaction items based on provided categories and sorting criteria.
    ///
    /// - Parameters:
    ///   - transactions: The collection of transaction items to filter and sort.
    ///   - categories: A set of category identifiers to filter the transactions by.
    ///   - sort: The sorting option to apply to the transactions.
    ///
    /// - Returns: A new collection of transaction items filtered and sorted according to the specified criteria.
    ///
    private func filterAndSortTransactions(_ transactions: [TransactionItem], _ categories: Set<Int>, sortedBy sort: SortingManager.SortOption) -> [TransactionItem] {
        var updatedTransactions = FilterManager.filterTransactions(selected: categories, transactions)
        
        SortingManager.sortTransactions(sortedBy: sort, transactions: &updatedTransactions)
        return updatedTransactions
    }
    
    /// Calculates the total currency amount from the provided array of transaction items.
    ///
    /// This method iterates through the array of transaction items and computes the total currency amount by summing up the amounts of each transaction.
    /// The resulting total is stored in the `currencyAmount` property.
    ///
    /// - Parameter transactions: An array of TransactionItem objects representing individual transactions.
    ///
    private func getCurrencyAmount(_ transactions: [TransactionItem]) {
        let totalAmount = transactions.reduce(Decimal.zero) { $0 + Decimal($1.transactionDetail.value.amount) }
        currencyAmount = totalAmount
    }
    
    /// ``SHOW ALERT``
    private func showAlertMessage() {
        showAlert.toggle()
    }
    
    //MARK: - DEINIT SETUP 🧨
    deinit { debugPrint("DEINIT - \(CLASS_ID) 💥") }
    //    public func deinitViewModelSetup() { dataCancellables.forEach { $0.cancel() } }
}
