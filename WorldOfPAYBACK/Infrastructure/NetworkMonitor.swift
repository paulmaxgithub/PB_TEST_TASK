//
//  NetworkMonitor.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import SwiftUI
import Network

fileprivate let CLASS_ID: String = "[NetworkMonitor]"

/// NetworkMonitor is a class responsible for monitoring the network status of the device.
///
/// This class provides functionality to observe changes in the network connectivity of the device.
/// It uses the Network.framework to monitor network paths and publishes updates to its `isOnline` property,
/// which indicates whether the device is currently connected to the internet.
///
/// USAGE:
///
///     - Create an instance of NetworkMonitor to start monitoring network status.
///     - Subscribe to the `isOnline` property to receive updates about the device's connectivity.
///
class NetworkMonitor: ObservableObject {
    
    @Published var isOnline: Bool = true
    
    private var monitor: NWPathMonitor?
    
    init() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isOnline = path.status == .satisfied
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor?.start(queue: queue)
    }
    
    //MARK: - DEINIT SETUP 🧨
    deinit { debugPrint("DEINIT - \(CLASS_ID) 💥"); monitor?.cancel() }
}
