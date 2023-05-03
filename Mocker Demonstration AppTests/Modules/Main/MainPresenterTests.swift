//
//  MainPresenterTests.swift
//  Mocker Demonstration AppTests
//
//  Created by Greg Strobl on 5/2/23.
//

import XCTest
@testable import Mocker_Demonstration_App

final class MainPresenterTests: XCTestCase {

    var view: MockMainView!
    var interactor: MockMainInteractorInput!
    var router: MockMainWireframe!
    var timerFactory: MockTimerFactory!
    var presenter: MainPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        view = MockMainView()
        interactor = MockMainInteractorInput()
        router = MockMainWireframe()
        timerFactory = MockTimerFactory()
        presenter = MainPresenter(
            view: view,
            interactor: interactor,
            router: router,
            timerFactory: timerFactory
        )
    }

    // MARK: - tapMeButtonTapped()
    
    func testTapMeButtonTapped() {
        
        presenter.tapMeButtonTapped()
        
        XCTAssertEqual(view.calledMethods, [.showTapMeButtonShowTapMeFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.showTapMeFlag])
        XCTAssertEqual(view.showTapMeFlag, false)
        XCTAssertEqual(interactor.calledMethods, [.tapMeButtonTappedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [])
    }
    
    // MARK: - showConfetti()
    
    func testShowConfetti_viewIsNil() {
        presenter.view = nil
        
        presenter.showConfetti()
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [])
    }
    
    func testShowConfetti_timerCreatedButNotFired() {
        
        presenter.showConfetti()
        
        XCTAssertNotNil(presenter.timer)
        XCTAssertEqual(view.calledMethods, [.showConfettiShowConfettiFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.showConfettiFlag])
        XCTAssertEqual(view.showConfettiFlag, true)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [.scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled])
        XCTAssertEqual(timerFactory.assignedParameters, [.interval, .repeats, .block])
        XCTAssertEqual(timerFactory.interval, MainPresenter.Duration.delay)
        XCTAssertEqual(timerFactory.repeats, false)
        XCTAssertNotNil(timerFactory.block)
    }
    
    func testShowConfetti_timerCreatedAndFired() {
        timerFactory.shouldCallBlock = true
        
        presenter.showConfetti()
        
        XCTAssertNotNil(presenter.timer)    // Not nil because the completion handler completes first
        XCTAssertEqual(view.calledMethods, [.showTapMeButtonShowTapMeFlagCalled, .showConfettiShowConfettiFlagCalled, .showSnowShowSnowFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.showTapMeFlag, .showConfettiFlag, .showSnowFlag])
        XCTAssertEqual(view.showTapMeFlag, true)
        XCTAssertEqual(view.showConfettiFlag, false)    // Set to true on the first call and false on the second
        XCTAssertEqual(view.showSnowFlag, false)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [.scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled])
        XCTAssertEqual(timerFactory.assignedParameters, [.interval, .repeats, .block])
        XCTAssertEqual(timerFactory.interval, MainPresenter.Duration.delay)
        XCTAssertEqual(timerFactory.repeats, false)
        XCTAssertNotNil(timerFactory.block)
    }
    
    // MARK: - showSnow()
    
    func testShowSnow_viewIsNil() {
        presenter.view = nil
        
        presenter.showSnow()
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [])
    }
    
    func testShowSnow_timerCreatedButNotFired() {
        
        presenter.showSnow()
        
        XCTAssertNotNil(presenter.timer)
        XCTAssertEqual(view.calledMethods, [.showSnowShowSnowFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.showSnowFlag])
        XCTAssertEqual(view.showSnowFlag, true)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [.scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled])
        XCTAssertEqual(timerFactory.assignedParameters, [.interval, .repeats, .block])
        XCTAssertEqual(timerFactory.interval, MainPresenter.Duration.delay)
        XCTAssertEqual(timerFactory.repeats, false)
        XCTAssertNotNil(timerFactory.block)
    }
    
    func testShowSnow_timerCreatedAndFired() {
        timerFactory.shouldCallBlock = true
        
        presenter.showSnow()
        
        XCTAssertNotNil(presenter.timer)    // Not nil because the completion handler completes first
        XCTAssertEqual(view.calledMethods, [.showTapMeButtonShowTapMeFlagCalled, .showConfettiShowConfettiFlagCalled, .showSnowShowSnowFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.showTapMeFlag, .showConfettiFlag, .showSnowFlag])
        XCTAssertEqual(view.showTapMeFlag, true)
        XCTAssertEqual(view.showConfettiFlag, false)    // Set to true on the first call and false on the second
        XCTAssertEqual(view.showSnowFlag, false)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [.scheduledTimerWithTimeIntervalIntervalRepeatsBlockCalled])
        XCTAssertEqual(timerFactory.assignedParameters, [.interval, .repeats, .block])
        XCTAssertEqual(timerFactory.interval, MainPresenter.Duration.delay)
        XCTAssertEqual(timerFactory.repeats, false)
        XCTAssertNotNil(timerFactory.block)
    }
    
    // MARK: - transitionBackToTapMeButton_viewIsNil()
    
    func testTransitionBackToTapMeButton_viewIsNil() {
        presenter.view = nil
        
        presenter.transitionBackToTapMeButton()
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [])
    }

    func testTransitionBackToTapMeButton() {
        let timer = MockTimer()
        presenter.timer = timer
        
        presenter.transitionBackToTapMeButton()

        XCTAssertNil(presenter.timer)
        XCTAssertEqual(view.calledMethods, [.showTapMeButtonShowTapMeFlagCalled, .showConfettiShowConfettiFlagCalled, .showSnowShowSnowFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.showTapMeFlag, .showConfettiFlag, .showSnowFlag])
        XCTAssertEqual(view.showTapMeFlag, true)
        XCTAssertEqual(view.showConfettiFlag, false)
        XCTAssertEqual(view.showSnowFlag, false)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(router.calledMethods, [])
        XCTAssertEqual(timerFactory.calledMethods, [])
        XCTAssertEqual(timer.calledMethods, [.invalidateCalled])
    }
}
