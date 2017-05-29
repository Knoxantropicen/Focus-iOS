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
        timeIntervalSetting.datePickerMode = .countDownTimer
        timeIntervalSetting.countDownDuration = TimeInterval(60)
        
        languageSetting.isEnabled = false   // Leave to further support for Chinese
        showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if Style.lightMode {
            themeSetting.selectedSegmentIndex = 0
        } else {
            themeSetting.selectedSegmentIndex = 1
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
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
//            self.descriptionText.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSwipe"), object: nil)
    }
    
    @IBAction func saveSettings(_ sender: UIButton) {
        removeAnimate()
        // Notification
        
        // Time Interval
        
        // Theme
        if themeSetting.selectedSegmentIndex == 0 {
            Style.themeLight()
        } else {
            Style.themeDark()
        }
        
        // Language
        
        
        // Activate
        self.view.superview?.backgroundColor = Style.mainBackgroundColor
        for subView in (self.view.superview?.subviews)! {
            if let textView = subView as? UITextView {
                textView.backgroundColor = Style.mainBackgroundColor
                textView.textColor = Style.mainTextColor
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
