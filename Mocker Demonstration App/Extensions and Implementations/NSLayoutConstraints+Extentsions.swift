//
//  NSLayoutConstraints+Extentsions.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

// Sourced from https://github.com/dkw5877/FunWithParticleEmitters

import UIKit.NSLayoutConstraint

extension NSLayoutConstraint {
    
    class func pin(view:UIView, to superview:UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
            view.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
