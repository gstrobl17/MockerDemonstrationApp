//
//  Demonstrating.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

protocol Demonstrating {
    func flipCoin() -> CoinFlipResult
    func retrieveSomeData(from url: URL) async throws -> Data
    func pretendToCheckForFile(at url: URL)
}
