//
//  MainContentViewModel.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 23/03/2024.
//

import Foundation
import Combine

fileprivate let CLASS_ID: String = "[MainContentViewModel]"

final class MainContentViewModel: ObservableObject {
    
    //MARK: States & Data
    @Published var isOnline: Bool = false
    
    //MARK: Services
    private let networkMonitor      = NetworkMonitor()
    private var dataCancellables    = Set<AnyCancellable>()
    
    init() { subscriptionSetup() }
    
    //MARK: Subscription Setup
    private func subscriptionSetup() {
        
        /// This code subscribes to the `isOnline` publisher from `networkMonitor`, which emits Boolean values indicating whether the device is online or offline. 
        /// Upon receiving a new value, the code updates the `isOnline` property of the current instance.
        /// The observation is performed on the main thread to ensure UI updates occur on the main queue. 
        networkMonitor.$isOnline
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self else { return }
                isOnline = state
            }
            .store(in: &dataCancellables)
    }
    
    //MARK: - DEINIT SETUP 🧨
    deinit {
        debugPrint("DEINIT - \(CLASS_ID) 💥")
        dataCancellables.forEach { $0.cancel() }
    }
}
