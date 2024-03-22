//
//  SwiftUIContainer.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import SwiftUI

/// A UIViewController subclass that serves as a container for SwiftUI views.
///
/// - NOTE: This class initializes a `UIHostingController` with a SwiftUI view (`MainContentView`),
/// adds the hosted SwiftUI view to its own view hierarchy, and manages the lifecycle of the hosted SwiftUI view controller.
///
class SwiftUIContainer: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Initialize the `UIHostingController` and retrieve the view from it
        let vc = UIHostingController(rootView: MainContentView())
        let swiftuiView = vc.view!
        
        /// Using constraints we can get unexpected behavior,
        /// some elements may be omitted, forgotten or deleted.
        /// Therefore we don't use any constrains, but use `frame` & `view.bounds`.
        swiftuiView.translatesAutoresizingMaskIntoConstraints = true
        swiftuiView.frame = view.bounds
        
        ///Add the `view controller` to the     destination view controller`.
        addChild(vc)
        view.addSubview(swiftuiView)
        
        ///Notify the `child view controller` that the move is complete.
        vc.didMove(toParent: self)
    }
}
