//
//  AmountSectionView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 22/03/2024.
//

import SwiftUI

fileprivate typealias TEXT = Constants_TEXT.TransactionsViewText

struct AmountSectionView: View {
    
    @EnvironmentObject private var vm: TransactionViewModel
    
    var body: some View {
        HStack {
            //MARK: TITLE
            Text(TEXT.currencyAmount.name)
                .font(.headline)
                .bold()
            
            Spacer()
            
            //MARK: AMOUNT RESULT TITLE
            Text(decimalToString(decimalValue: vm.currencyAmount))
        }
        .padding(.horizontal)
    }
    
    //MARK: PRIVATE
    
    /// Converts a `Decimal` value to its string representation.
    ///
    /// This method takes a `Decimal` value as input and converts it to a string using a `NumberFormatter` configured with the decimal number style.
    /// The resulting string representation of the Decimal value is returned. If conversion fails, an empty string is returned.
    ///
    /// - Parameters:
    ///   - decimalValue: The Decimal value to convert to a string.
    ///   
    /// - Returns: A string representation of the Decimal value.
    ///
    private func decimalToString(decimalValue: Decimal) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSDecimalNumber(decimal: decimalValue)) ?? ""
    }
}

//#Preview { AmountSectionView() }
