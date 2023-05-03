//
//  MockMainInteractorOutput.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import UIKit

class MockMainInteractorOutput: MainInteractorOutputProtocol {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let showConfettiCalled = Method(rawValue: 1 << 0)
        static let showSnowCalled = Method(rawValue: 1 << 1)
    }
    private(set) var calledMethods = Method()


    func reset() {
        calledMethods = []
    }

    // MARK: - Methods for Protocol Conformance

    func showConfetti() {
        calledMethods.insert(.showConfettiCalled)
    }

    func showSnow() {
        calledMethods.insert(.showSnowCalled)
    }

}

extension MockMainInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.showConfettiCalled) {
            handleFirst()
            value += ".showConfettiCalled"
        }
        if self.contains(.showSnowCalled) {
            handleFirst()
            value += ".showSnowCalled"
        }

        value += "]"
        return value
    }
}
