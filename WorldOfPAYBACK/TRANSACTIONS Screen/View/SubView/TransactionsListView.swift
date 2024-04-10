//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 22/03/2024.
//

import SwiftUI

fileprivate typealias TEXT = Constants_TEXT.TransactionsViewText

struct TransactionsListView: View {
    
    @EnvironmentObject private var vm: TransactionViewModel
    
    var body: some View {
        List(vm.transactions, id: \.id) { transaction in
            NavigationLink {
                TransactionDetailsLoadingView(item: .constant(transaction))
            } label: {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(transaction.partnerDisplayName)
                            .font(.callout)
                            .bold()
                            .foregroundStyle(.blue)
                        
                        Text(transaction.transactionDetail.description ?? "N/A")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(dateSetup(transaction.transactionDetail.bookingDate))
                            .font(.system(size: 8, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("\(TEXT.cat_.name) \(transaction.category)")
                        .font(.system(size: 8))
                        .bold()
                        .padding(14)
                        .background(
                            Circle()
                                .fill(Color.gray)
                                .opacity(0.7)
                        )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(TEXT.currency.name)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .baselineOffset(4.0)
                            .kerning(2.0)
                            .underline(true)
                        
                        Text(transaction.transactionDetail.value.currency)
                            .font(.title3)
                            .bold()
                    }
                    .padding(.trailing, 8)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(TEXT.amount.name)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .baselineOffset(4.0)
                            .kerning(2.0)
                            .underline(true)
                        
                        Text("\(transaction.transactionDetail.value.amount)")
                            .font(.title3)
                            .bold()
                    }
                }
            }
        }
        .listStyle(.inset)
    }
    
    //MARK: PRIVATE
    
    /// Formats a given string date into a specific format.
    ///
    /// This method takes a string representing a date and formats it using a custom date formatter defined in the `StringDateFormatter` class.
    /// It returns the formatted date string. If the formatting operation fails or if the input string is invalid, an empty string is returned.
    ///
    /// - Parameter stringDate: A string representation of the date to be formatted.
    /// 
    /// - Returns: A formatted string representation of the date, or an empty string if formatting fails.
    ///
    private func dateSetup(_ stringDate: String) -> String {
        StringDateFormatter.formatDateString(stringDate) ?? ""
    }
    
}

//#Preview { TransactionsListView() }
