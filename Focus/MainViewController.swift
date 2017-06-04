//
//  MainViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/15.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var typingArea: UITextView!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var swipeInstructionLabel: UILabel!
    
    public var pushNotification = PushNotification()
    
    private let defaults = UserDefaults.standard
    
    func setThemeIcon() {
        settingsButton.setImage(Style.settingsIcon, for: .normal)
        checkButton.setImage(Style.checkIcon, for: .normal)
        plusButton.setImage(Style.plusIcon, for: .normal)
    }
    
    func setThemeColor() {
        view.backgroundColor = Style.mainBackgroundColor
        typingArea.backgroundColor = Style.mainBackgroundColor
        typingArea.textColor = Style.mainTextColor
        mode.setTitleColor(Style.symbolColor, for: .normal)
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
        let widgetDefaults = UserDefaults(suiteName: "group.knox.Focuson.extension")
        let widgetDictionary = widgetDefaults?.dictionaryRepresentation()
        widgetDictionary?.keys.forEach { key in
            widgetDefaults?.removeObject(forKey: key)
        }
        widgetDefaults?.synchronize()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        typingArea.delegate = self
        
        // resetDefaults()
        
        if UserDefaults.standard.bool(forKey: "LightMode") {
            Style.themeLight()
        } else {
            Style.themeDark()
        }
        
        if UserDefaults.standard.bool(forKey: "EnglishLanguage") {
            Language.setEnglish()
        } else {
            Language.setChinese()
        }
        
        if !UserDefaults.standard.bool(forKey: "initialLaunch") {
            Style.themeLight()
            Language.setEnglish()
            
            var displayInstructionCount = 0
            
            func displayInstruction() {
                UIView.animate(withDuration: 1.5, animations: {
                    self.swipeInstructionLabel.alpha = 0.8
                }, completion:{(finished : Bool)  in
                    if finished {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.swipeInstructionLabel.alpha = 0.0
                        }, completion:{(finished : Bool) in
                            displayInstructionCount += 1
                            if displayInstructionCount < 3 {
                                displayInstruction()
                            }
                        })
                    }
                })
            }
            
            displayInstruction()
            UserDefaults.standard.set(true, forKey: "initialLaunch")
        }
        
        setThemeIcon()
        setThemeColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MainViewController.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if let mainAffairString = UserDefaults.standard.string(forKey: "mainAffairString") {
            typingArea.text = mainAffairString
            if (mainAffairString == Language.mainModel) {
                typingArea.alpha = 0.3
            } else {
                typingArea.alpha = 1
                typingArea.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
            }
        }
        
        if MainViewController.isQuestion == UserDefaults.standard.bool(forKey: "mainModeRevBool") {
            MainViewController.isQuestion = !MainViewController.isQuestion
            changeMode(mode)
        }
        
        PushNotification.isNotificationEnabled = UserDefaults.standard.bool(forKey: "notificationEnabled")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if defaults.bool(forKey: "outerReplaced") {
            typingArea.text = defaults.string(forKey: "mainAffairString")
            if typingArea.text != Language.mainModel {
                typingArea.alpha = 1
                typingArea.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
            }
            if MainViewController.isQuestion {
                mode.setTitle("?", for: .normal)
            } else {
                mode.setTitle("!", for: .normal)
            }
            defaults.set(false, forKey: "outerReplaced")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        swipeInstructionLabel.alpha = 0.0
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.alpha = 1
        textView.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        if textView.text == Language.mainModel {
            textView.text = ""
        }
        
        if text.contains("\n") {
            hideKeyboard()
            return false
        }
        if textView.text.characters.count + (text.characters.count - range.length) >= 120 {
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        defaults.set(textView.text, forKey: "mainAffairString")
        UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(textView.text, forKey: "mainAffairString")
    }
    
    func hideKeyboard() {
        if typingArea.text == "" {
            typingArea.text = Language.mainModel
            typingArea.alpha = 0.3
            typingArea.font = UIFont(name: "HelveticaNeue-UltraLightItalic", size: 30)
        }
        defaults.set(typingArea.text, forKey: "mainAffairString")
        UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(typingArea.text, forKey: "mainAffairString")
        view.endEditing(true)
    }
    
    @IBOutlet weak var mode: UIButton!
    
    static var isQuestion = true
    
    @IBAction func changeMode(_ sender: UIButton) {
        if let mode = sender.currentTitle {
            if mode == "?" {
                sender.setTitle("!", for: .normal)
                MainViewController.isQuestion = false
            } else {
                sender.setTitle("?", for: .normal)
                MainViewController.isQuestion = true
            }
            defaults.set(!MainViewController.isQuestion, forKey: "mainModeRevBool")
            UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(!MainViewController.isQuestion, forKey: "mainModeRevBool")
        }
    }
    
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    @IBAction func createAffair(_ sender: UIButton) {
        if typingArea.text == Language.mainModel {
            return
        }
        let createAffair = DoingTableViewController()
        createAffair.addAffair(newAffair: typingArea.text, newMode: mode.currentTitle!)
        typingArea.text = ""
//        defaults.set(typingArea.text, forKey: "mainAffairString")
        hideKeyboard()
        
        createLabel.text = Language.createAction
        createLabel.textColor = Style.mainTextColor
        UIView.animate(withDuration: 1.0, animations: {
            self.createLabel.alpha = 0.5
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.createLabel.alpha = 0.0
                })
            }
        })
    }

    @IBAction func finishAffair(_ sender: UIButton) {
        if typingArea.text == Language.mainModel {
            return
        }
        let finishAffair = DoneTableViewController()
        finishAffair.addAffair(newAffair: typingArea.text, newMode: mode.currentTitle!)
        typingArea.text = ""
        hideKeyboard()
        
        finishLabel.text = Language.finishAction
        finishLabel.textColor = Style.mainTextColor
        UIView.animate(withDuration: 1.0, animations: {
            self.finishLabel.alpha = 0.5
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.finishLabel.alpha = 0.0
                })
            }
        })
    }
    
    @IBAction func helpShowSettings(_ sender: UIButton) {
        showSettings(sender)
    }
    
    @IBAction func showSettings(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
}
