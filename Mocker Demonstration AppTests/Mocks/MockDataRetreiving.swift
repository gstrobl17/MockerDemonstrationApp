//
//  MockDataRetreiving.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockDataRetreiving: DataRetreiving {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let dataForRequestDelegateCalled = Method(rawValue: 1 << 0)
        static let dataFromUrlDelegateCalled = Method(rawValue: 1 << 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let request = MethodParameter(rawValue: 1 << 0)
        static let delegate = MethodParameter(rawValue: 1 << 1)
        static let url = MethodParameter(rawValue: 1 << 2)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var request: URLRequest?
    private(set) var delegate: URLSessionTaskDelegate?
    private(set) var url: URL?

    // MARK: - Variables to Use as Method Return Values

    var dataForRequestDelegateReturnValue: (Data, URLResponse)!
    var dataFromUrlDelegateReturnValue: (Data, URLResponse)!

    var errorToThrow: Error!
    var dataForRequestDelegateShouldThrowError = false
    var dataFromUrlDelegateShouldThrowError = false


    func reset() {
        calledMethods = []
        assignedParameters = []
        request = nil
        delegate = nil
        url = nil
    }

    // MARK: - Methods for Protocol Conformance

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        calledMethods.insert(.dataForRequestDelegateCalled)
        self.request = request
        assignedParameters.insert(.request)
        self.delegate = delegate
        assignedParameters.insert(.delegate)
        if dataForRequestDelegateShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return dataForRequestDelegateReturnValue
    }

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        calledMethods.insert(.dataFromUrlDelegateCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.delegate = delegate
        assignedParameters.insert(.delegate)
        if dataFromUrlDelegateShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return dataFromUrlDelegateReturnValue
    }

}

extension MockDataRetreiving.Method: CustomStringConvertible {
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

        if self.contains(.dataForRequestDelegateCalled) {
            handleFirst()
            value += ".dataForRequestDelegateCalled"
        }
        if self.contains(.dataFromUrlDelegateCalled) {
            handleFirst()
            value += ".dataFromUrlDelegateCalled"
        }

        value += "]"
        return value
    }
}

extension MockDataRetreiving.MethodParameter: CustomStringConvertible {
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

        if self.contains(.request) {
            handleFirst()
            value += ".request"
        }
        if self.contains(.delegate) {
            handleFirst()
            value += ".delegate"
        }
        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }

        value += "]"
        return value
    }
}

extension MockDataRetreiving: CustomReflectable {
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
