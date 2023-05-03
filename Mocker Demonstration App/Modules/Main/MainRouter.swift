//
//  MainRouter.swift
//  Mocker Demonstration App
//
//  Created Greg Strobl on 5/2/23.
//

import UIKit

class MainRouter: MainWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = MainViewController(nibName: nil, bundle: nil)
        let facade = DemonstrationFacade(
            coinFlipper: CoinFlipper(),
            dataRetreiver: FoundationDataRetreiver(),
            fileManager: FileManager.default,
            notificationPoster: NotificationCenter.default
        )
        let interactor = MainInteractor(facade: facade)
        let router = MainRouter()
        let presenter = MainPresenter(view: view, interactor: interactor, router: router, timerFactory: FoundationTimerFactory())

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
