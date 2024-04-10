//
//  NoConnectionView.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

import SwiftUI

fileprivate typealias TEXT = Constants_TEXT.UnavailableView
fileprivate typealias IMAGE = Constants_IMAGE.SystemImage

/// Displays a view indicating that there is no internet connection available.
///
/// This struct represents a view that is used to inform the user when there is no internet connection available.
/// It utilizes the `ContentUnavailableView` component to display a title and description,
/// with an icon indicating the absence of a Wi-Fi connection.
///
struct NoConnectionView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Label(TEXT.title.name, systemImage: IMAGE.wifi_slash.name)
        }, description: {
            Text(TEXT.description.name)
                .font(.caption)
        })
    }
}

#if DEBUG
#Preview { NoConnectionView() }
#endif
