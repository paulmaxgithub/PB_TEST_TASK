//
//  StringDateFormatter.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//

import Foundation

/// Utility struct for formatting string-based date representations.
///
/// This struct provides a static method `formatDateString(_:)` that takes a string representation of a date and attempts to parse it into a Date object using an extension method `toDate()` on String.
/// If successful, it formats the parsed date into a string using a specific date format ("dd-MM-yyyy HH:mm") and the "en_US" locale, returning the formatted date string.
/// If the input string cannot be parsed into a date, nil is returned.
struct StringDateFormatter {
    
    /// Formats a string-based date representation into a specific date format.
    ///
    /// - Parameter dateString: The string representation of the date to be formatted.
    /// - Returns: A formatted date string in the "dd-MM-yyyy HH:mm" format, or nil if the input string cannot be parsed into a date.
    ///
    static func formatDateString(_ dateString: String) -> String? {
        if let date = dateString.toDate() {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            outputDateFormatter.locale = Locale(identifier: "en_US")
            return outputDateFormatter.string(from: date)
        }
        return nil
    }
}
