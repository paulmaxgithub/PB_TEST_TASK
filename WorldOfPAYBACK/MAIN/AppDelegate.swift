//
//  AppDelegate.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

import UIKit

//MARK: We are currently in a transition phase of moving from UIKit to SwiftUI.

/// Use `AppDelegate` for implementation and using existing code in `UIKit`
@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialViewControllerSetup()
        return true
    }
    
    /// Sets up the initial view controller for the application.
    ///
    /// - NOTE: This method creates a new UIWindow instance with the size of the main screen,
    /// initializes the root view controller as an instance of `SwiftUIContainer`,
    /// and sets it as the root view controller of the window.
    /// Finally, it makes the window visible and brings it to the front.
    ///
    private func initialViewControllerSetup() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = SwiftUIContainer()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
