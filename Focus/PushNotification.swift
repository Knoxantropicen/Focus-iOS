//
//  PushNotification.swift
//  Focus
//
//  Created by Pika Ma on 17/5/6.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import Foundation
import UserNotifications

struct PushNotification {
    
    var title = ""
    var dateCreated = Date(timeIntervalSince1970: 0)
    var isQuestion = true
    
    public mutating func replace(title: String, dateCreated: Date, isQuestion: Bool) {
        self.dateCreated = dateCreated
        self.title = title
        self.isQuestion = isQuestion
        push()
    }
    
    public mutating func update(dateModified: Date) {
        self.dateCreated = dateModified
        push()
    }
    
    public func push() {
        let content = UNMutableNotificationContent()
        if isQuestion {
            content.title = "May the idea be with you:"
        } else {
            content.title = "Do it right now:"
        }
        content.body = title
        content.categoryIdentifier = "message"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "focus.message", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
