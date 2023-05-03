//
//  FoundationDataRetreiver.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

struct FoundationDataRetreiver: DataRetreiving {
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(from: url, delegate: delegate)
    }
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: request, delegate: delegate)
    }
    
}
