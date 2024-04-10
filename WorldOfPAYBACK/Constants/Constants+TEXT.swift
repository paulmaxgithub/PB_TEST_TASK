//
//  Constants+TEXT.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

/// `Constants_TEXT` provides static text constants used throughout the application.
///
/// This struct defines enums for different views and modifiers within the app, each containing text constants associated with specific UI elements or alerts.
/// By organizing text constants in a structured manner, it promotes reusability, consistency, and easy localization of text across the application.
///
struct Constants_TEXT {
    
    //MARK: - `NoConnectionView`
    
    enum UnavailableView {
        case title, description
        
        var name: String {
            switch self {
            case .title: return "No Connection"
            case .description: return "Oops! It looks like you're offline. Please connect to a network to access the app."
            }
        }
    }
    
    //MARK: - `TransactionsView`
    
    enum TransactionsViewText {
        case transactions
        case chooseCategory, currencyAmount
        case cat_, currency, amount
        
        var name: String {
            switch self {
            case .transactions:     return "Transactions"
            case .chooseCategory:   return "CHOOSE CATEGORY:"
            case .currencyAmount:   return "CURRENCY AMOUNT:"
            case .cat_:             return "CAT."
            case .currency:         return "CURRENCY"
            case .amount:           return "AMOUNT"
            }
        }
    }
    
    //MARK: - `AlertModifier`
    
    enum AlertModifierText {
        case loadingFailedTitle, loadingFailedDescription, reloadButton
        
        var name: String {
            switch self {
            case .loadingFailedTitle:       return "Data Loading Failed"
            case .loadingFailedDescription: return "Failed to load data. Please try again later."
            case .reloadButton:             return "RELOAD"
                
            }
        }
    }
}
