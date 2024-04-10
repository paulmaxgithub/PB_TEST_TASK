//
//  NetworkMonitor.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
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
final class NetworkMonitor {
    
    @Published var isOnline: Bool = true
    
    private var monitor: NWPathMonitor?
    
    init() {
        monitor = NWPathMonitor()
        
        /// Determines the online status of the device based on the network path's status.
        /// - Parameters:
        ///   - path: The network path status object representing the device's network connectivity.
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                isOnline = (path.status == .satisfied) && (path.status != .requiresConnection)
                debugPrint("\(CLASS_ID): ONLINE is \(path.status == .satisfied) / \(path.status != .requiresConnection)")
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor?.start(queue: queue)
    }
    
    //MARK: - DEINIT SETUP 🧨
    deinit { debugPrint("DEINIT - \(CLASS_ID) 💥"); monitor?.cancel() }
}
