//
//  CoinFlipper.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

struct CoinFlipper: CoinFlipping {
    
    func flip() -> CoinFlipResult {
        Bool.random() ? .heads : .tails
    }
    
}
