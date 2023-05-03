//
//  MainInteractor.swift
//  Mocker Demonstration App
//
//  Created Greg Strobl on 5/2/23.
//

import UIKit

class MainInteractor {

    weak var presenter: MainInteractorOutputProtocol?
    let facade: Demonstrating
    
    init(facade: Demonstrating) {
        self.facade = facade
    }

}

extension MainInteractor: MainInteractorInputProtocol {

    func tapMeButtonTapped() {
        switch facade.flipCoin() {
        case .heads:
            presenter?.showSnow()
        case .tails:
            presenter?.showConfetti()
        }
    }

}
