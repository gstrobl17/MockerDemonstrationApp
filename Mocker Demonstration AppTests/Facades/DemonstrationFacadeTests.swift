//
//  DemonstrationFacadeTests.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/3/23.
//

import XCTest
@testable import Mocker_Demonstration_App

final class DemonstrationFacadeTests: XCTestCase {
    
    var coinFlipper: MockCoinFlipping!
    var dataRetreiver: MockDataRetreiving!
    var fileManager: MockFileManaging!
    var notificationPoster: MockNotificationPosting!
    var facade: DemonstrationFacade!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        coinFlipper = MockCoinFlipping()
        dataRetreiver = MockDataRetreiving()
        fileManager = MockFileManaging()
        notificationPoster = MockNotificationPosting()
        facade = DemonstrationFacade(
            coinFlipper: coinFlipper,
            dataRetreiver: dataRetreiver,
            fileManager: fileManager,
            notificationPoster: notificationPoster
        )
    }

    // MARK: - flipCoin()
    
    func testFlipCoin_coinFlipperReturnsHeads() {
        coinFlipper.flipReturnValue = .heads
        
        let result = facade.flipCoin()

        XCTAssertEqual(result, .heads)
        XCTAssertEqual(coinFlipper.calledMethods, [.flipCalled])
        XCTAssertEqual(dataRetreiver.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(notificationPoster.calledMethods, [])
    }
    
    func testFlipCoin_coinFlipperReturnsTails() {
        coinFlipper.flipReturnValue = .tails
        
        let result = facade.flipCoin()

        XCTAssertEqual(result, .tails)
        XCTAssertEqual(coinFlipper.calledMethods, [.flipCalled])
        XCTAssertEqual(dataRetreiver.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(notificationPoster.calledMethods, [])
    }

    // MARK: - retrieveSomeData(from:)

    func testRetrieveSomeData_attmemptThrowsError() async throws {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        dataRetreiver.errorToThrow = MockError.testing
        dataRetreiver.dataFromUrlDelegateShouldThrowError = true
        var resultingData: Data?
        var resultingError: Error?

        do {
            resultingData = try await facade.retrieveSomeData(from: url)
        } catch {
            resultingError = error
        }
        
        XCTAssertNil(resultingData)
        XCTAssertNotNil(resultingError)
        XCTAssertTrue(resultingError is MockError)
        XCTAssertEqual(coinFlipper.calledMethods, [])
        XCTAssertEqual(dataRetreiver.calledMethods, [.dataFromUrlDelegateCalled])
        XCTAssertEqual(dataRetreiver.assignedParameters, [.delegate, .url])
        XCTAssertNil(dataRetreiver.delegate)
        XCTAssertEqual(dataRetreiver.url, url)
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(notificationPoster.calledMethods, [])
    }

    func testRetrieveSomeData_attmemptReturnsData() async throws {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        let data = try XCTUnwrap("123".data(using: .utf8))
        dataRetreiver.dataFromUrlDelegateReturnValue = (data, URLResponse())
        var resultingData: Data?
        var resultingError: Error?

        do {
            resultingData = try await facade.retrieveSomeData(from: url)
        } catch {
            resultingError = error
        }
        
        XCTAssertNotNil(resultingData)
        XCTAssertEqual(resultingData, data)
        XCTAssertNil(resultingError)
        XCTAssertEqual(coinFlipper.calledMethods, [])
        XCTAssertEqual(dataRetreiver.calledMethods, [.dataFromUrlDelegateCalled])
        XCTAssertEqual(dataRetreiver.assignedParameters, [.delegate, .url])
        XCTAssertNil(dataRetreiver.delegate)
        XCTAssertEqual(dataRetreiver.url, url)
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(notificationPoster.calledMethods, [])
    }

    // MARK: - pretendToCheckForFile(at:)
    
    func testPretendToCheckForFile_fileExists() throws {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        fileManager.fileExistsAtPathPathReturnValue = true
        
        facade.pretendToCheckForFile(at: url)

        XCTAssertEqual(coinFlipper.calledMethods, [])
        XCTAssertEqual(dataRetreiver.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(fileManager.assignedParameters, [.path])
        XCTAssertEqual(fileManager.path, url.absoluteString)
        XCTAssertEqual(notificationPoster.calledMethods, [.postNameANameObjectAnObjectCalled])
        XCTAssertEqual(notificationPoster.assignedParameters, [.aName, .anObject])
        XCTAssertEqual(notificationPoster.aName, .someNotification1)
        XCTAssertNil(notificationPoster.anObject)
        XCTAssertEqual(notificationPoster.postedNames, [.someNotification1])
    }
    
    func testPretendToCheckForFile_fileDoesNotExist() throws {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        fileManager.fileExistsAtPathPathReturnValue = false
        
        facade.pretendToCheckForFile(at: url)

        XCTAssertEqual(coinFlipper.calledMethods, [])
        XCTAssertEqual(dataRetreiver.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(fileManager.assignedParameters, [.path])
        XCTAssertEqual(fileManager.path, url.absoluteString)
        XCTAssertEqual(notificationPoster.calledMethods, [.postNameANameObjectAnObjectCalled])
        XCTAssertEqual(notificationPoster.assignedParameters, [.aName, .anObject])
        XCTAssertEqual(notificationPoster.aName, .someNotification3)    // For last notification posted
        XCTAssertNotNil(notificationPoster.anObject)                    // For last notification posted
        XCTAssertTrue(notificationPoster.anObject is DemonstrationFacade)
        if let object = notificationPoster.anObject as? DemonstrationFacade {
            XCTAssertTrue(object === facade)
        }
        XCTAssertEqual(notificationPoster.postedNames, [.someNotification2, .someNotification3])
    }

}
