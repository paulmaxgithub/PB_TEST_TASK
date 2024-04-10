//
//  TransactionsView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//

import SwiftUI

fileprivate typealias TEXT = Constants_TEXT.TransactionsViewText
fileprivate typealias ALERT = Constants_TEXT.AlertModifierText

struct TransactionsView: View {
    
    @StateObject private var vm = TransactionViewModel()
    
    var body: some View {
        
        if vm.isDataLoading {
            ProgressView()
                .tint(.blue)
                .scaleEffect(2)
        } else {
            ZStack {
                NavigationStack {
                    VStack(spacing: 8) {
                        //MARK: CATEGORY
                        CategorySectionView()
                        
                        //MARK: AMOUNT
                        if vm.selectedCategories.isEmpty == false {
                            AmountSectionView()
                        }
                        
                        Divider()
                        
                        //MARK: TRANSACTIONS LIST
                        TransactionsListView()
                    }
                    .navigationTitle(TEXT.transactions.name)
                    .padding(.horizontal, 8)
                    
                }
                .environmentObject(vm)
                .opacity(vm.showAlert ? 0 : 1.0)
            }
            
            //MARK: ALERT SETUP
            .alert(ALERT.loadingFailedTitle.name, isPresented: $vm.showAlert) {
                Button { vm.loadTransactionData()
                } label: { Text(ALERT.reloadButton.name) }
            } message: {
                Text(ALERT.loadingFailedDescription.name)
            }
        }
    }
}

#if DEBUG
#Preview { TransactionsView() }
#endif
