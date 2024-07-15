//
//  DemonstrationFacadeTests.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/3/23.
//

import MacrosForStroblMocks
import XCTest
@testable import Mocker_Demonstration_App

@UsesStroblMocks
final class DemonstrationFacadeTests: XCTestCase {
    
    @StroblMock var coinFlipper: MockCoinFlipping!
    @StroblMock var dataRetreiver: MockDataRetreiving!
    @StroblMock var fileManager: MockFileManaging!
    @StroblMock var notificationPoster: MockNotificationPosting!
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
        verifyStroblMocksUnused(except: [.coinFlipper])
        XCTAssertEqual(coinFlipper.calledMethods, [.flipCalled])
    }
    
    func testFlipCoin_coinFlipperReturnsTails() {
        coinFlipper.flipReturnValue = .tails
        
        let result = facade.flipCoin()

        XCTAssertEqual(result, .tails)
        verifyStroblMocksUnused(except: [.coinFlipper])
        XCTAssertEqual(coinFlipper.calledMethods, [.flipCalled])
    }

    // MARK: - retrieveSomeData(from:)

    func testRetrieveSomeData_attemptThrowsError() async throws {
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
        verifyStroblMocksUnused(except: [.dataRetreiver])
        XCTAssertEqual(dataRetreiver.calledMethods, [.dataFromUrlDelegateCalled])
        XCTAssertEqual(dataRetreiver.assignedParameters, [.delegate, .url])
        XCTAssertNil(dataRetreiver.delegate)
        XCTAssertEqual(dataRetreiver.url, url)
    }

    func testRetrieveSomeData_attemptReturnsData() async throws {
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
        verifyStroblMocksUnused(except: [.dataRetreiver])
        XCTAssertEqual(dataRetreiver.calledMethods, [.dataFromUrlDelegateCalled])
        XCTAssertEqual(dataRetreiver.assignedParameters, [.delegate, .url])
        XCTAssertNil(dataRetreiver.delegate)
        XCTAssertEqual(dataRetreiver.url, url)
    }

    // MARK: - pretendToCheckForFile(at:)
    
    func testPretendToCheckForFile_fileExists() throws {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        fileManager.fileExistsAtPathPathReturnValue = true
        
        facade.pretendToCheckForFile(at: url)

        verifyStroblMocksUnused(except: [.fileManager, .notificationPoster])
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

        verifyStroblMocksUnused(except: [.fileManager, .notificationPoster])
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
