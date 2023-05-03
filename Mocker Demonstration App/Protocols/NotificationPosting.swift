//
//  NotificationPosting.swift
//  Mocker Demonstration App
//
//  Created by Greg Strobl on 5/3/23.
//

import Foundation

protocol NotificationPosting {

    func post(name aName: NSNotification.Name, object anObject: Any?)
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?)

}

extension NotificationPosting {

    func post(name aName: NSNotification.Name) {
        post(name: aName, object: nil)
    }

}
