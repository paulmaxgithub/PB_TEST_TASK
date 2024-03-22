//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import SwiftUI

/// - By compiling and running the project, the ``TransactionDetailsView`` can be
/// initialized several times about how many `rows` are visible in the `List`.
/// - With this approach, when we wrap one structure in another, we call `init()`
/// only once, when we go to the detail view.
struct TransactionDetailsLoadingView: View {
    
    @Binding var item: TransactionItem?
    
    var body: some View {
        
        ZStack {
            if let item = item {
                TransactionDetailsView(item: item)
            }
        }
    }
}

fileprivate struct TransactionDetailsView: View {
    
    public let item: TransactionItem
    
    init(item: TransactionItem) { self.item = item }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(item.partnerDisplayName)
                .font(.title)
            Text(item.transactionDetail.description ?? "")
                .font(.footnote)
        }
    }
}

#if DEBUG
#Preview { TransactionDetailsView(
    item: TransactionItem(partnerDisplayName: "REWE GROUP",
                          alias: Alias(reference: ""),
                          category: 1,
                          transactionDetail: TransactionDetail(description: "Punkte sammlen",
                                                               bookingDate: "",
                                                               value: Value(amount: 0,
                                                                            currency: "PBP")),
                          id: UUID().uuidString))
}
#endif
