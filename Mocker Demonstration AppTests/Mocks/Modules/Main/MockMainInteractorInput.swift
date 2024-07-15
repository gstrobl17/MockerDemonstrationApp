//
//  MockMainInteractorInput.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import UIKit

class MockMainInteractorInput: MainInteractorInputProtocol {

    // MARK: - Variables for Protocol Conformance

    var presenter: MainInteractorOutputProtocol?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let tapMeButtonTappedCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
    }
    private(set) var assignedParameters = MethodParameter()


    func reset() {
        calledMethods = []
        assignedParameters = []
    }

    // MARK: - Methods for Protocol Conformance

    func tapMeButtonTapped() {
        calledMethods.insert(.tapMeButtonTappedCalled)
    }

}

extension MockMainInteractorInput.Method: CustomStringConvertible {
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

        if self.contains(.tapMeButtonTappedCalled) {
            handleFirst()
            value += ".tapMeButtonTappedCalled"
        }

        value += "]"
        return value
    }
}

extension MockMainInteractorInput.MethodParameter: CustomStringConvertible {
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

extension MockMainInteractorInput: CustomReflectable {
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
