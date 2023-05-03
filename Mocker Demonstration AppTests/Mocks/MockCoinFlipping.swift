//
//  MockCoinFlipping.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockCoinFlipping: CoinFlipping {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let flipCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    // MARK: - Variables to Use as Method Return Values

    var flipReturnValue = CoinFlipResult.heads


    func reset() {
        calledMethods = []
    }

    // MARK: - Methods for Protocol Conformance

    func flip() -> CoinFlipResult {
        calledMethods.insert(.flipCalled)
        return flipReturnValue
    }

}

extension MockCoinFlipping.Method: CustomStringConvertible {
    var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }

        if self.contains(.flipCalled) {
            handleFirst()
            value += ".flipCalled"
        }

        value += "]"
        return value
    }
}
