//
//  MainViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/15.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import UserNotifications
=======
>>>>>>> Test commit

class MainViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var typingArea: UITextView!
    
<<<<<<< HEAD
//    var contentSize = CGSize()
    static var text = PushNotification()
    static var typingText: String = ""
    
    var isGrantedNotificationAccess: Bool = false
    
    private let textModel = "Type your sentence here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        typingArea.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        typingArea.delegate = self
//        typingArea.becomeFirstResponder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MainViewController.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge],
            completionHandler: { (granted, error) in
                self.isGrantedNotificationAccess = granted
            }
        )
        
=======
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
>>>>>>> Test commit
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
<<<<<<< HEAD
        if typingArea.text == textModel {
            MainViewController.typingText = "(Swipe back and add something...)"
        } else {
            MainViewController.typingText = typingArea.text
            
            MainViewController.text.replace(title: typingArea.text, dateCreated: Date(timeIntervalSinceNow: 0), isQuestion: true)
        }
=======
>>>>>>> Test commit
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.alpha = 1
<<<<<<< HEAD
=======
        textView.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
>>>>>>> Test commit
        if textView.text == textModel {
            textView.text = ""
        }
        if text.contains("\n") {
            hideKeyboard()
<<<<<<< HEAD
            MainViewController.text.replace(title: typingArea.text, dateCreated: Date(timeIntervalSinceNow: 0), isQuestion: true)
=======
>>>>>>> Test commit
            return false
        }
        return true
    }
    
    func hideKeyboard() {
        if typingArea.text == "" {
            typingArea.text = textModel
            typingArea.alpha = 0.3
<<<<<<< HEAD
        }
        view.endEditing(true)
    }
    
    @IBOutlet weak var mode: UIButton! {
        didSet {
            
        }
    }
    
    @IBAction func changeMode(_ sender: UIButton) {
        (sender.currentTitle == "?") ? sender.setTitle("!", for: .normal) : sender.setTitle("?", for: .normal)
        let doingTable = DoingTableViewController()
        doingTable.changeMainMode(sender.currentTitle!)
=======
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
>>>>>>> Test commit
    }
    
    
    @IBAction func createAffair(_ sender: UIButton) {
        if typingArea.text == textModel {
            return
        }
        let createAffair = DoingTableViewController()
<<<<<<< HEAD
        createAffair.addAffair(newAffair: typingArea.text)
=======
        createAffair.addAffair(newAffair: typingArea.text, newMode: mode.currentTitle!)
>>>>>>> Test commit
        typingArea.text = ""
        hideKeyboard()
    }

    @IBAction func finishAffair(_ sender: UIButton) {
        if typingArea.text == textModel {
            return
        }
        let finishAffair = DoneTableViewController()
<<<<<<< HEAD
        finishAffair.addAffair(newAffair: typingArea.text)
=======
        finishAffair.addAffair(newAffair: typingArea.text, newMode: mode.currentTitle!)
>>>>>>> Test commit
        typingArea.text = ""
        hideKeyboard()
    }
    
<<<<<<< HEAD
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if let tv = object as? UITextView {
//            var topCorrect: CGFloat? = (tv.bounds.size.height - tv.contentSize.height * tv.zoomScale) / 2.0
//            topCorrect = (topCorrect! < CGFloat(0.0) ? 0.0 : topCorrect)
//            tv.contentOffset = CGPoint()
//            tv.contentOffset.x = 0
//            tv.contentOffset.y = -topCorrect!
//        }
//    }
    
=======
    @IBAction func showSettings(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
>>>>>>> Test commit
}
