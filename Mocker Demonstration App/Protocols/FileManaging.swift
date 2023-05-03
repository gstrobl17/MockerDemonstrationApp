//
//  FileManaging.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/3/23.
//

import Foundation

protocol FileManaging {
    
    func fileExists(atPath path: String) -> Bool
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws
    func removeItem(atPath path: String) throws
    
}
