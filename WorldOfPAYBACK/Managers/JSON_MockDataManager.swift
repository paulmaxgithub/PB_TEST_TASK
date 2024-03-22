//
//  JSON_MockDataManager.swift
//  WorldOfPAYBACK
//
//  Created by PAULMAX iOS DEV on 20/03/2024.
//
//  All rights reserved, 2022 Loyalty Partner GmbH.
//  Any transfer to third parties and/or reproduction is not permitted.
//

import Foundation
import Combine

fileprivate let STRUCT_ID:      String = "[JSON_MockDataManager]"
fileprivate let JSON_FILE_NAME: String = "PBTransactions"

/// Service for fetching JSON data.
struct JSON_MockDataManager {
    
    /// Fetches JSON data from a local file.
    ///
    /// - Check if the JSON file exists in the main bundle
    /// - If the file doesn't exist, return a failure publisher with a corresponding error
    ///
    /// - Returns: A publisher that emits the fetched JSON data or an error.
    static public func fetchJSONData() -> AnyPublisher<Data, Error> {
        
        guard let url = Bundle.main.url(forResource: JSON_FILE_NAME, withExtension: "json") else {
            return Fail(error: NSError(domain: "JSONService", code: 404,
                                       userInfo: [NSLocalizedDescriptionKey: "\(STRUCT_ID) - JSON file not found"]))
            .eraseToAnyPublisher()
        }
        
        do {
            let data = try Data(contentsOf: url)
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
