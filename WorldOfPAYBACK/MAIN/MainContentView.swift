//
//  MainContentView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import SwiftUI

/// Represents the main content view of the application.
///
/// - NOTE: This SwiftUI view dynamically displays either the `TransactionsView` 
/// when the device is online or the `NoConnectionView` when the device is offline,
/// based on the state of the `networkMonitor` object.
///
struct MainContentView: View {
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        if networkMonitor.isOnline {
            TransactionsView()
        } else {
            NoConnectionView()
        }
    }
}

#if DEBUG
#Preview { MainContentView(networkMonitor: NetworkMonitor()) }
#endif
