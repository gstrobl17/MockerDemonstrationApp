//
//  MockFileManaging.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/3/23.
//

@testable import Mocker_Demonstration_App
import Foundation

class MockFileManaging: FileManaging {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: Int
        static let fileExistsAtPathPathCalled = Method(rawValue: 1 << 0)
        static let createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled = Method(rawValue: 1 << 1)
        static let removeItemAtPathPathCalled = Method(rawValue: 1 << 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let path = MethodParameter(rawValue: 1 << 0)
        static let url = MethodParameter(rawValue: 1 << 1)
        static let createIntermediates = MethodParameter(rawValue: 1 << 2)
        static let attributes = MethodParameter(rawValue: 1 << 3)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var path: String?
    private(set) var url: URL?
    private(set) var createIntermediates: Bool?
    private(set) var attributes: [FileAttributeKey: Any]?

    // MARK: - Variables to Use as Method Return Values

    var fileExistsAtPathPathReturnValue = false

    var errorToThrow: Error!
    var createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesShouldThrowError = false
    var removeItemAtPathPathShouldThrowError = false

    func reset() {
        calledMethods = []
        assignedParameters = []
        path = nil
        url = nil
        createIntermediates = nil
        attributes = nil
    }

    // MARK: - Methods for Protocol Conformance

    func fileExists(atPath path: String) -> Bool {
        calledMethods.insert(.fileExistsAtPathPathCalled)
        self.path = path
        assignedParameters.insert(.path)
        return fileExistsAtPathPathReturnValue
    }

    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws {
        calledMethods.insert(.createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.createIntermediates = createIntermediates
        assignedParameters.insert(.createIntermediates)
        self.attributes = attributes
        assignedParameters.insert(.attributes)
        if createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
    }

    func removeItem(atPath path: String) throws {
        calledMethods.insert(.removeItemAtPathPathCalled)
        self.path = path
        assignedParameters.insert(.path)
        if removeItemAtPathPathShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
    }

}

extension MockFileManaging.Method: CustomStringConvertible {
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

        if self.contains(.fileExistsAtPathPathCalled) {
            handleFirst()
            value += ".fileExistsAtPathPathCalled"
        }
        if self.contains(.createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled) {
            handleFirst()
            value += ".createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled"
        }
        if self.contains(.removeItemAtPathPathCalled) {
            handleFirst()
            value += ".removeItemAtPathPathCalled"
        }

        value += "]"
        return value
    }
}

extension MockFileManaging.MethodParameter: CustomStringConvertible {
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

        if self.contains(.path) {
            handleFirst()
            value += ".path"
        }
        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }
        if self.contains(.createIntermediates) {
            handleFirst()
            value += ".createIntermediates"
        }
        if self.contains(.attributes) {
            handleFirst()
            value += ".attributes"
        }

        value += "]"
        return value
    }
}
