//
//  MainViewController.swift
//  Mocker Demonstration App
//
//  Created Greg Strobl on 5/2/23.
//

import UIKit

class MainViewController: UIViewController {

	var presenter: MainPresenterProtocol?
    weak var confetti: ConfettiParticleView?
    weak var snow: SnowParticleView?
    weak var tapMeButton: UIButton?

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let confetti = ConfettiParticleView()
        confetti.particleImage = UIImage(named: "confetti")
        confetti.translatesAutoresizingMaskIntoConstraints = false
        confetti.alpha = 0
        view.addSubview(confetti)
        NSLayoutConstraint.pin(view: confetti, to: view)
        self.confetti = confetti
        
        let snow = SnowParticleView()
        snow.particleImage = UIImage(named: "snow")
        snow.translatesAutoresizingMaskIntoConstraints = false
        snow.alpha = 0
        view.addSubview(snow)
        NSLayoutConstraint.pin(view: snow, to: view)
        self.snow = snow
        
        let tapMeButton = UIButton()
        tapMeButton.translatesAutoresizingMaskIntoConstraints = false
        tapMeButton.backgroundColor = .white
        tapMeButton.layer.cornerRadius = 10
        tapMeButton.setTitle("Tap Me", for: .normal)
        tapMeButton.setTitleColor(.black, for: .normal)
        tapMeButton.addTarget(self, action: #selector(tapMeButonTapped), for: .touchUpInside)
        view.addSubview(tapMeButton)
        self.tapMeButton = tapMeButton
        NSLayoutConstraint.activate([
            tapMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapMeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tapMeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    @objc private func tapMeButonTapped() {
        presenter?.tapMeButtonTapped()
    }

}

extension MainViewController: MainViewProtocol {

    enum Duraction {
        static let fadeIn = TimeInterval(0.5)
        static let fadeOut = TimeInterval(0.25)
    }
    
    func showTapMeButton(_ flag: Bool) {
        guard let tapMeButton else { return }
        show(tapMeButton, flag: flag)
    }
    
    func showConfetti(_ flag: Bool) {
        guard let confetti else { return }
        show(confetti, flag: flag)
    }
    
    func showSnow(_ flag: Bool) {
        guard let snow else { return }
        show(snow, flag: flag)
    }

    private func show(_ view: UIView, flag: Bool) {
        let duration = flag ? Duraction.fadeIn : Duraction.fadeOut
        let newAlpha: CGFloat = flag ? 1.0 : 0.0
        
        guard view.alpha != newAlpha else { return }
        
        UIView.animate(withDuration: duration) {
            view.alpha = newAlpha
        }
    }
    
}
