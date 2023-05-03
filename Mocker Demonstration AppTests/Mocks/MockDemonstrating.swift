//
//  MockDemonstrating.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockDemonstrating: Demonstrating {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let flipCoinCalled = Method(rawValue: 1 << 0)
        static let retrieveSomeDataFromUrlCalled = Method(rawValue: 1 << 1)
        static let pretendToCheckForFileAtUrlCalled = Method(rawValue: 1 << 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let url = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var url: URL?

    // MARK: - Variables to Use as Method Return Values

    var flipCoinReturnValue = CoinFlipResult.heads
    var retrieveSomeDataFromUrlReturnValue = Data()

    var errorToThrow: Error!
    var retrieveSomeDataFromUrlShouldThrowError = false


    func reset() {
        calledMethods = []
        assignedParameters = []
        url = nil
    }

    // MARK: - Methods for Protocol Conformance

    func flipCoin() -> CoinFlipResult {
        calledMethods.insert(.flipCoinCalled)
        return flipCoinReturnValue
    }

    func retrieveSomeData(from url: URL) async throws -> Data {
        calledMethods.insert(.retrieveSomeDataFromUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
        if retrieveSomeDataFromUrlShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return retrieveSomeDataFromUrlReturnValue
    }

    func pretendToCheckForFile(at url: URL) {
        calledMethods.insert(.pretendToCheckForFileAtUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

}

extension MockDemonstrating.Method: CustomStringConvertible {
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

        if self.contains(.flipCoinCalled) {
            handleFirst()
            value += ".flipCoinCalled"
        }
        if self.contains(.retrieveSomeDataFromUrlCalled) {
            handleFirst()
            value += ".retrieveSomeDataFromUrlCalled"
        }
        if self.contains(.pretendToCheckForFileAtUrlCalled) {
            handleFirst()
            value += ".pretendToCheckForFileAtUrlCalled"
        }

        value += "]"
        return value
    }
}

extension MockDemonstrating.MethodParameter: CustomStringConvertible {
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

        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }

        value += "]"
        return value
    }
}
