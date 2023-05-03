//
//  MainInteractorTests.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

import XCTest
@testable import Mocker_Demonstration_App

final class MainInteractorTests: XCTestCase {

    var presenter: MockMainInteractorOutput!
    var facade: MockDemonstrating!
    var interactor: MainInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        presenter = MockMainInteractorOutput()
        facade = MockDemonstrating()
        interactor = MainInteractor(facade: facade)
        interactor.presenter = presenter
    }

    // MARK: - tapMeButtonTapped()
    
    func testTapMeButtonTapped_facadeReturnsHeads() {
        facade.flipCoinReturnValue = .heads

        interactor.tapMeButtonTapped()
        
        XCTAssertEqual(presenter.calledMethods, [.showSnowCalled])
        XCTAssertEqual(facade.calledMethods, [.flipCoinCalled])
        XCTAssertEqual(facade.assignedParameters, [])
    }
    
    func testTapMeButtonTapped_facadeReturnsTails() {
        facade.flipCoinReturnValue = .tails

        interactor.tapMeButtonTapped()
        
        XCTAssertEqual(presenter.calledMethods, [.showConfettiCalled])
        XCTAssertEqual(facade.calledMethods, [.flipCoinCalled])
        XCTAssertEqual(facade.assignedParameters, [])
    }
}
