//
//  SettingsViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/5/29.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var viewFrame: UIView!
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var notificationSetting: UISwitch!
    @IBOutlet weak var timeIntervalSetting: UIDatePicker!
    @IBOutlet weak var themeSetting: UISegmentedControl!
    @IBOutlet weak var languageSetting: UISegmentedControl!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        settingsLabel.text = Language.settings
        notificationLabel.text = Language.notification
        intervalLabel.text = Language.timeInterval
        themeLabel.text = Language.theme
        themeSetting.setTitle(Language.light, forSegmentAt: 0)
        themeSetting.setTitle(Language.dark, forSegmentAt: 1)
        languageLabel.text = Language.language
        languageSetting.setTitle(Language.english, forSegmentAt: 0)
        languageSetting.setTitle(Language.chinese, forSegmentAt: 1)
        saveButton.setTitle(Language.save, for: .normal)
        
        timeIntervalSetting.datePickerMode = .countDownTimer
        timeIntervalSetting.countDownDuration = TimeInterval(60)
        
        showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func notificationEnabled(_ sender: UISwitch) {
        if sender.isOn {
            timeIntervalSetting.isEnabled = true
        } else {
            timeIntervalSetting.isEnabled = false
        }
    }
    
    func setThemeColor() {
        viewFrame.backgroundColor = Style.popBackgroundColor
        let textColor = Style.mainTextColor
        settingsLabel.textColor = textColor
        intervalLabel.textColor = textColor
        notificationLabel.textColor = textColor
        themeLabel.textColor = textColor
        languageLabel.textColor = textColor
        saveButton.setTitleColor(textColor, for: .normal)
    }
    
    func setOptions() {
        
        if let widgetNotificationStatus = UserDefaults(suiteName: "group.knox.Focuson.extension")?.bool(forKey: "notificationEnabled") {
            if widgetNotificationStatus {
                UserDefaults.standard.set(true, forKey: "notificationEnabled")
            } else {
                UserDefaults.standard.set(false, forKey: "notificationEnabled")
            }
            defaults.set(true, forKey: "veryFirstLaunch")
        }
        
        notificationSetting.isOn = UserDefaults.standard.bool(forKey: "notificationEnabled")
        
        if notificationSetting.isOn {
            timeIntervalSetting.isEnabled = true
        } else {
            timeIntervalSetting.isEnabled = false
        }
        
        if let timeInterval = UserDefaults.standard.object(forKey: "timeInterval") {
            timeIntervalSetting.countDownDuration = timeInterval as! TimeInterval
        }
        
        if Style.lightMode {
            themeSetting.selectedSegmentIndex = 0
        } else {
            themeSetting.selectedSegmentIndex = 1
        }
        
        if Language.EnglishLanguage {
            languageSetting.selectedSegmentIndex = 0
        } else {
            languageSetting.selectedSegmentIndex = 1
        }
        
        if !defaults.bool(forKey: "veryFirstLaunch") {
            notificationSetting.isOn = false
            timeIntervalSetting.isEnabled = false
            timeIntervalSetting.countDownDuration = 60
            defaults.set(true, forKey: "veryFirstLaunch")
        }
    }
    
    func showAnimate() {
        setThemeColor()
        setOptions()
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableSwipe"), object: nil)
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSwipe"), object: nil)
    }
    
    @IBAction func saveSettings(_ sender: UIButton) {
        removeAnimate()
        
        // Notification
        if notificationSetting.isOn {
            UserDefaults.standard.set(true, forKey: "notificationEnabled")
            UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(true, forKey: "notificationEnabled")
        } else {
            UserDefaults.standard.set(false, forKey: "notificationEnabled")
            UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(false, forKey: "notificationEnabled")
        }
        PushNotification.isNotificationEnabled = notificationSetting.isOn
        
        // Time Interval
        UserDefaults.standard.set(timeIntervalSetting.countDownDuration, forKey: "timeInterval")
        PushNotification.timeInterval = timeIntervalSetting.countDownDuration
        
        // Theme
        if self.themeSetting.selectedSegmentIndex == 0 {
            Style.themeLight()
        } else {
            Style.themeDark()
        }
        
        // Language
        if languageSetting.selectedSegmentIndex == 0 {
            Language.setEnglish()
        } else {
            Language.setChinese()
        }
        
        // Activate
        self.view.superview?.backgroundColor = Style.mainBackgroundColor
        for subView in (self.view.superview?.subviews)! {
            if let textView = subView as? UITextView {
                textView.backgroundColor = Style.mainBackgroundColor
                textView.textColor = Style.mainTextColor
                if textView.text == Language.englishMainModel && !Language.EnglishLanguage {
                    textView.text = Language.chineseMainModel
                } else if textView.text == Language.chineseMainModel && Language.EnglishLanguage {
                    textView.text = Language.englishMainModel
                }
            }
            if let stackView = subView as? UIStackView {
                for subsubView in stackView.subviews {
                    if let button = subsubView as? UIButton {
                        switch button.restorationIdentifier! {
                        case "checkButton":
                            button.setImage(Style.checkIcon, for: .normal)
                        case "plusButton":
                            button.setImage(Style.plusIcon, for: .normal)
                        default: break
                        }
                    }
                }
            }
            if let button = subView as? UIButton {
                switch button.restorationIdentifier! {
                case "symbolButton":
                    button.setTitleColor(Style.symbolColor, for: .normal)
                case "settingsButton":
                    button.setImage(Style.settingsIcon, for: .normal)
                default: break
                }
            }
        }
        
    }
}
