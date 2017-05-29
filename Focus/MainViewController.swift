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
    
    private let defaults = UserDefaults.standard
    
    private let textModel = "Start typing here..."
    
//    override func viewWillAppear(_ animated: Bool) {
//        view.backgroundColor = Style.mainBackgroundColor
//    }
    
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        typingArea.delegate = self
        
        if UserDefaults.standard.bool(forKey: "LightMode") {
            Style.themeLight()
        } else {
            Style.themeDark()
        }
        
        setThemeIcon()
        setThemeColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MainViewController.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if let mainAffairString = UserDefaults.standard.string(forKey: "mainAffairString") {
            typingArea.text = mainAffairString
            if (mainAffairString == textModel) {
                typingArea.alpha = 0.3
            } else {
                typingArea.alpha = 1
            }
        }
        
        if MainViewController.isQuestion == UserDefaults.standard.bool(forKey: "mainModeRevBool") {
            MainViewController.isQuestion = !MainViewController.isQuestion
            changeMode(mode)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.alpha = 1
        textView.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        if textView.text == textModel {
            textView.text = ""
        }
        if text.contains("\n") {
            hideKeyboard()
            return false
        }
        return true
    }
    
    func hideKeyboard() {
        if typingArea.text == "" {
            typingArea.text = textModel
            typingArea.alpha = 0.3
            typingArea.font = UIFont(name: "HelveticaNeue-UltraLightItalic", size: 30)
        }
        defaults.set(typingArea.text, forKey: "mainAffairString")
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
        }
    }
    
    
    @IBAction func createAffair(_ sender: UIButton) {
        if typingArea.text == textModel {
            return
        }
        let createAffair = DoingTableViewController()
        createAffair.addAffair(newAffair: typingArea.text, newMode: mode.currentTitle!)
        typingArea.text = ""
        hideKeyboard()
    }

    @IBAction func finishAffair(_ sender: UIButton) {
        if typingArea.text == textModel {
            return
        }
        let finishAffair = DoneTableViewController()
        finishAffair.addAffair(newAffair: typingArea.text, newMode: mode.currentTitle!)
        typingArea.text = ""
        hideKeyboard()
    }
    
    @IBAction func showSettings(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
}
