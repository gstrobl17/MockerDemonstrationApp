//
//  MockTimerFactory.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockTimerFactory: TimerFactory {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let interval = MethodParameter(rawValue: 1 << 0)
        static let repeats = MethodParameter(rawValue: 1 << 1)
        static let block = MethodParameter(rawValue: 1 << 2)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var interval: TimeInterval?
    private(set) var repeats: Bool?
    private(set) var block: (@Sendable (Timer) -> Void)?

    // MARK: - Variables to Use as Method Return Values

    var scheduledTimerWithTimeIntervalIntervalRepeatsBlockReturnValue: Timing = MockTimer()
    var timerForClosureBlock = Timer()

    // MARK: - Variables to Use to Control Completion Handlers

    var shouldCallBlock = false

    func reset() {
        calledMethods = []
        assignedParameters = []
        interval = nil
        repeats = nil
        block = nil
    }

    // MARK: - Methods for Protocol Conformance

    func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        repeats: Bool,
        block: @escaping @Sendable (Timer) -> Void
    ) -> Timing {
        calledMethods.insert(.scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled)
        self.interval = interval
        assignedParameters.insert(.interval)
        self.repeats = repeats
        assignedParameters.insert(.repeats)
        self.block = block
        assignedParameters.insert(.block)
        if shouldCallBlock {
            block(timerForClosureBlock)
        }
        return scheduledTimerWithTimeIntervalIntervalRepeatsBlockReturnValue
    }

}

extension MockTimerFactory.Method: CustomStringConvertible {
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

        if self.contains(.scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled) {
            handleFirst()
            value += ".scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled"
        }

        value += "]"
        return value
    }
}

extension MockTimerFactory.MethodParameter: CustomStringConvertible {
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

        if self.contains(.interval) {
            handleFirst()
            value += ".interval"
        }
        if self.contains(.repeats) {
            handleFirst()
            value += ".repeats"
        }
        if self.contains(.block) {
            handleFirst()
            value += ".block"
        }

        value += "]"
        return value
    }
}

extension MockTimerFactory: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
                "assignedParameters": assignedParameters
               ],
               displayStyle: .none
        )
    }
    
}
