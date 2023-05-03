//
//  MockTimer.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockTimer: Timing {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let invalidateCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()


    func reset() {
        calledMethods = []
    }

    // MARK: - Methods for Protocol Conformance

    func invalidate() {
        calledMethods.insert(.invalidateCalled)
    }

}

extension MockTimer.Method: CustomStringConvertible {
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

        if self.contains(.invalidateCalled) {
            handleFirst()
            value += ".invalidateCalled"
        }

        value += "]"
        return value
    }
}
