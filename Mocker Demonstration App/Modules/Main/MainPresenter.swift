//
//  MainPresenter.swift
//  Mocker Demonstration App
//
//  Created Greg Strobl on 5/2/23.
//

import UIKit

class MainPresenter {

    weak internal var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    let router: MainWireframeProtocol
    let timerFactory: TimerFactory
    var timer: Timing?

    init(view: MainViewProtocol, interactor: MainInteractorInputProtocol?, router: MainWireframeProtocol, timerFactory: TimerFactory) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.timerFactory = timerFactory
    }

}

extension MainPresenter: MainPresenterProtocol {

    func tapMeButtonTapped() {
        view?.showTapMeButton(false)
        interactor?.tapMeButtonTapped()
    }

}

extension MainPresenter: MainInteractorOutputProtocol {

    enum Duration {
        static let delay = TimeInterval(0.9)
    }
    
    func showConfetti() {
        guard let view else { return }
        view.showConfetti(true)
        timer = timerFactory.scheduledTimer(withTimeInterval: Duration.delay, repeats: false, block: { [weak self] _ in
            self?.transitionBackToTapMeButton()
        })
    }
    
    func showSnow() {
        guard let view else { return }
        view.showSnow(true)
        timer = timerFactory.scheduledTimer(withTimeInterval: Duration.delay, repeats: false, block: { [weak self] _ in
            self?.transitionBackToTapMeButton()
        })
    }

    func transitionBackToTapMeButton() {
        guard let view else { return }
        view.showTapMeButton(true)
        view.showConfetti(false)
        view.showSnow(false)
        timer?.invalidate()
        timer = nil
    }
    
}
