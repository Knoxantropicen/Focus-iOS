//
//  TodayViewController.swift
//  FocusonWidget
//
//  Created by TianKnox on 2017/6/2.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var affairLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    private let widgetDefaults = UserDefaults(suiteName: "group.knox.Focuson.extension")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        affairLabel.text = widgetDefaults?.string(forKey: "mainAffairString")
        if affairLabel.text == Language.englishMainModel || affairLabel.text == Language.chineseMainModel {
            affairLabel.text = Language.widgetModel
        } else {
            if let mode = widgetDefaults?.bool(forKey: "mainModeRevBool") {
                if mode {
                    affairLabel.text?.append("!")
                } else {
                    affairLabel.text?.append("?")
                }
            }
        }
        if let notificationEnabled = widgetDefaults?.bool(forKey: "notificationEnabled") {
            if notificationEnabled {
                notificationSwitch.isOn = true
            } else {
                notificationSwitch.isOn = false
            }
        } else {
            notificationSwitch.isOn = false
        }
    }
    
    @IBAction func changeNotification(_ sender: UISwitch) {
        if sender.isOn {
            PushNotification.push()
            widgetDefaults?.set(true, forKey: "notificationEnabled")
        } else {
            PushNotification.remove()
            widgetDefaults?.set(false, forKey: "notificationEnabled")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
