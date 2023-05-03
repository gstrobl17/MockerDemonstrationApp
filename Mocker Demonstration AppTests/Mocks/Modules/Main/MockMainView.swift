//
//  MockMainView.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import UIKit

class MockMainView: MainViewProtocol {

    // MARK: - Variables for Protocol Conformance

    var presenter: MainPresenterProtocol?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let showTapMeButtonShowTapMeFlagCalled = Method(rawValue: 1 << 0)
        static let showConfettiShowConfettiFlagCalled = Method(rawValue: 1 << 1)
        static let showSnowShowSnowFlagCalled = Method(rawValue: 1 << 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let showTapMeFlag = MethodParameter(rawValue: 1 << 0)
        static let showConfettiFlag = MethodParameter(rawValue: 1 << 1)
        static let showSnowFlag = MethodParameter(rawValue: 1 << 2)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var showTapMeFlag: Bool?
    private(set) var showConfettiFlag: Bool?
    private(set) var showSnowFlag: Bool?


    func reset() {
        calledMethods = []
        assignedParameters = []
        showTapMeFlag = nil
        showConfettiFlag = nil
        showSnowFlag = nil
    }

    // MARK: - Methods for Protocol Conformance

    func showTapMeButton(_ showTapMeFlag: Bool) {
        calledMethods.insert(.showTapMeButtonShowTapMeFlagCalled)
        self.showTapMeFlag = showTapMeFlag
        assignedParameters.insert(.showTapMeFlag)
    }

    func showConfetti(_ showConfettiFlag: Bool) {
        calledMethods.insert(.showConfettiShowConfettiFlagCalled)
        self.showConfettiFlag = showConfettiFlag
        assignedParameters.insert(.showConfettiFlag)
    }

    func showSnow(_ showSnowFlag: Bool) {
        calledMethods.insert(.showSnowShowSnowFlagCalled)
        self.showSnowFlag = showSnowFlag
        assignedParameters.insert(.showSnowFlag)
    }

}

extension MockMainView.Method: CustomStringConvertible {
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

        if self.contains(.showTapMeButtonShowTapMeFlagCalled) {
            handleFirst()
            value += ".showTapMeButtonShowTapMeFlagCalled"
        }
        if self.contains(.showConfettiShowConfettiFlagCalled) {
            handleFirst()
            value += ".showConfettiShowConfettiFlagCalled"
        }
        if self.contains(.showSnowShowSnowFlagCalled) {
            handleFirst()
            value += ".showSnowShowSnowFlagCalled"
        }

        value += "]"
        return value
    }
}

extension MockMainView.MethodParameter: CustomStringConvertible {
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

        if self.contains(.showTapMeFlag) {
            handleFirst()
            value += ".showTapMeFlag"
        }
        if self.contains(.showConfettiFlag) {
            handleFirst()
            value += ".showConfettiFlag"
        }
        if self.contains(.showSnowFlag) {
            handleFirst()
            value += ".showSnowFlag"
        }

        value += "]"
        return value
    }
}
