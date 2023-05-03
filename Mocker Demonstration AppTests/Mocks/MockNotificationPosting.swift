//
//  MockNotificationPosting.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/3/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockNotificationPosting: NotificationPosting {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let postNameANameObjectAnObjectCalled = Method(rawValue: 1 << 0)
        static let postNameANameObjectAnObjectUserInfoAUserInfoCalled = Method(rawValue: 1 << 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let aName = MethodParameter(rawValue: 1 << 0)
        static let anObject = MethodParameter(rawValue: 1 << 1)
        static let aUserInfo = MethodParameter(rawValue: 1 << 2)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var aName: NSNotification.Name?
    private(set) var anObject: Any?
    private(set) var aUserInfo: [AnyHashable: Any]?

    private(set) var postedNames = [NSNotification.Name]()

    func reset() {
        calledMethods = []
        assignedParameters = []
        aName = nil
        anObject = nil
        aUserInfo = nil
        postedNames = []
    }

    // MARK: - Methods for Protocol Conformance

    func post(name aName: NSNotification.Name, object anObject: Any?) {
        calledMethods.insert(.postNameANameObjectAnObjectCalled)
        self.aName = aName
        postedNames.append(aName)
        assignedParameters.insert(.aName)
        self.anObject = anObject
        assignedParameters.insert(.anObject)
    }

    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?) {
        calledMethods.insert(.postNameANameObjectAnObjectUserInfoAUserInfoCalled)
        self.aName = aName
        postedNames.append(aName)
        assignedParameters.insert(.aName)
        self.anObject = anObject
        assignedParameters.insert(.anObject)
        self.aUserInfo = aUserInfo
        assignedParameters.insert(.aUserInfo)
    }

}

extension MockNotificationPosting.Method: CustomStringConvertible {
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

        if self.contains(.postNameANameObjectAnObjectCalled) {
            handleFirst()
            value += ".postNameANameObjectAnObjectCalled"
        }
        if self.contains(.postNameANameObjectAnObjectUserInfoAUserInfoCalled) {
            handleFirst()
            value += ".postNameANameObjectAnObjectUserInfoAUserInfoCalled"
        }

        value += "]"
        return value
    }
}

extension MockNotificationPosting.MethodParameter: CustomStringConvertible {
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

        if self.contains(.aName) {
            handleFirst()
            value += ".aName"
        }
        if self.contains(.anObject) {
            handleFirst()
            value += ".anObject"
        }
        if self.contains(.aUserInfo) {
            handleFirst()
            value += ".aUserInfo"
        }

        value += "]"
        return value
    }
}
