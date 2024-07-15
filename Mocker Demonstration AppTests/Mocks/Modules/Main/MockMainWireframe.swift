//
//  MockMainWireframe.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import UIKit

class MockMainWireframe: MainWireframeProtocol {

    // MARK: - Variables for Protocol Conformance

    var viewController: UIViewController?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
    }
    private(set) var calledMethods = Method()

    struct StaticMethod: OptionSet {
        let rawValue: Int
        static let createModuleCalled = StaticMethod(rawValue: 1 << 0)
    }
    private(set) static var calledStaticMethods = StaticMethod()

    struct MethodParameter: OptionSet {
        let rawValue: Int
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables to Use as Method Return Values

    static var createModuleReturnValue: UIViewController!


    func reset() {
        calledMethods = []
        MockMainWireframe.calledStaticMethods = []
        assignedParameters = []
    }

    // MARK: - Methods for Protocol Conformance

    static func createModule() -> UIViewController {
        calledStaticMethods.insert(.createModuleCalled)
        return createModuleReturnValue
    }

}

extension MockMainWireframe.Method: CustomStringConvertible {
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


        value += "]"
        return value
    }
}

extension MockMainWireframe.StaticMethod: CustomStringConvertible {
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

        if self.contains(.createModuleCalled) {
            handleFirst()
            value += ".createModuleCalled"
        }

        value += "]"
        return value
    }
}

extension MockMainWireframe.MethodParameter: CustomStringConvertible {
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


        value += "]"
        return value
    }
}

extension MockMainWireframe: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
                "calledStaticMethods": MockMainWireframe.calledStaticMethods,
                "assignedParameters": assignedParameters
               ],
               displayStyle: .none
        )
    }
    
}
