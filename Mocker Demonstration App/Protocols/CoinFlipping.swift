//
//  CoinFlipping.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

enum CoinFlipResult {
    case heads
    case tails
}

protocol CoinFlipping {
    
    func flip() -> CoinFlipResult
    
}
