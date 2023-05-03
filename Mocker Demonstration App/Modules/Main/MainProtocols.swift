//
//  MainProtocols.swift
//  Mocker Demonstration App
//
//  Created Greg Strobl on 5/2/23.
//

import UIKit

// MARK: Wireframe -
protocol MainWireframeProtocol: AnyObject {

    var viewController: UIViewController? { get set }

    static func createModule() -> UIViewController

}

// MARK: Interactor -
protocol MainInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
    func showConfetti()
    func showSnow()
}

protocol MainInteractorInputProtocol: AnyObject {

    var presenter: MainInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
    func tapMeButtonTapped()
}

// MARK: Presenter -
protocol MainPresenterProtocol: AnyObject {

    var interactor: MainInteractorInputProtocol? { get set }

    /* ViewController -> Presenter */
    func tapMeButtonTapped()
}

// MARK: View -
protocol MainViewProtocol: AnyObject {

    var presenter: MainPresenterProtocol? { get set }

    /* Presenter -> ViewController */
    func showTapMeButton(_ showTapMeFlag: Bool)
    func showConfetti(_ showConfettiFlag: Bool)
    func showSnow(_ showSnowFlag: Bool)
}
