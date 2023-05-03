//
//  DemonstrationFacade.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/2/23.
//

import Foundation

class DemonstrationFacade {
    
    let coinFlipper: CoinFlipping
    let dataRetreiver: DataRetreiving
    let fileManager: FileManaging
    let notificationPoster: NotificationPosting

    init(
        coinFlipper: CoinFlipping,
        dataRetreiver: DataRetreiving,
        fileManager: FileManaging,
        notificationPoster: NotificationPosting
    ) {
        self.coinFlipper = coinFlipper
        self.dataRetreiver = dataRetreiver
        self.fileManager = fileManager
        self.notificationPoster = notificationPoster
    }
    
}

extension DemonstrationFacade: Demonstrating {
    
    func flipCoin() -> CoinFlipResult {
        coinFlipper.flip()
    }
    
    func retrieveSomeData(from url: URL) async throws -> Data {
        let (data, _) = try await dataRetreiver.data(from: url)
        return data
    }

    func pretendToCheckForFile(at url: URL) {
        
        if fileManager.fileExists(atPath: url.absoluteString) {
            notificationPoster.post(name: .someNotification1)
        } else {
            notificationPoster.post(name: .someNotification2)
            notificationPoster.post(name: .someNotification3, object: self)
        }
        
    }

}
