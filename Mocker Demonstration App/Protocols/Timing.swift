//
//  Timing.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

/// This protocol exists so that the TimerFactory can return an object that can represent a Timer but doesn't have to be an actual Timer.
@objc public protocol Timing: AnyObject {
    func invalidate()
}
