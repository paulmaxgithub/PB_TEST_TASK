//
//  Constants+IMAGE.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 21/03/2024.
//

/// `Constants_IMAGE` related to image names used throughout the application.
///
/// This struct defines a set of constants representing system images commonly used within the application.
/// - The `SystemImage` enum encapsulates the names of these images, providing a centralized location for managing image names.
/// - Each case in the enum corresponds to a specific system image, and the `name` property returns the corresponding image name as a String.
///
/// - NOTE:  This approach promotes consistency and maintainability by avoiding hardcoded image names throughout the codebase.
///
struct Constants_IMAGE {
    
    enum SystemImage {
        case wifi_slash, square_slash_fill
        
        var name: String {
            switch self {
            case .wifi_slash:           return "wifi.slash"
            case .square_slash_fill:    return "square.slash.fill"
            }
        }
    }
}
