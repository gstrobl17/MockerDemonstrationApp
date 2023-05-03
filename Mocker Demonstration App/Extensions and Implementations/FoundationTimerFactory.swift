//
//  FoundationTimerFactory.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

struct FoundationTimerFactory: TimerFactory {
    
    func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping @Sendable (Timer) -> Void) -> Timing {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
    }
    
}
