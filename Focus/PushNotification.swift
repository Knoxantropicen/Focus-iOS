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
    
    static var title = ""
    static var timeInterval : TimeInterval = 60
    static var isNotificationEnabled = false
    
    static let standardDefaults = UserDefaults.standard
    static let widgetDefaults = UserDefaults(suiteName: "group.knox.Focuson.extension")
    
    public static func push() {
        
        var text = ""
        var revMode = false
        
        if let widgetText = widgetDefaults?.string(forKey: "mainAffairString") {
            text = widgetText
        } else {
            if let mainText = standardDefaults.string(forKey: "mainAffairString") {
                text = mainText
            }
        }
        
        if let widgetMode = widgetDefaults?.bool(forKey: "mainModeRevBool") {
            revMode = widgetMode
        } else {
            revMode = standardDefaults.bool(forKey: "mainModeRevBool")
        }
        
        if text != "" && text != Language.chineseMainModel && text != Language.englishMainModel {
            PushNotification.title = text
            if (!revMode) {
                PushNotification.title.append("?")
            }
            else {
                PushNotification.title.append("!")
            }
            let content = UNMutableNotificationContent()
            content.body = PushNotification.title
            content.categoryIdentifier = "message"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: PushNotification.timeInterval, repeats: true)
            let request = UNNotificationRequest(identifier: "focus.message", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        } else {
            PushNotification.remove()
        }
    }
    
    public static func remove() {
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = ""
        content.categoryIdentifier = "message"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let request = UNNotificationRequest(identifier: "focus.message", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
