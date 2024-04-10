//
//  String+EXT.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//

import Foundation

extension String {
    
    /// Converts a string representation of a date in the format "yyyy-MM-dd'T'HH:mm:ssZ" to a Date object.
    ///
    /// - Returns: A `Date` object representing the parsed date string, or nil if the string does not match the expected format.
    ///
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
