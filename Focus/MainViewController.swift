//
//  MainViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/15.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var typingArea: UITextView!
    
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if typingArea.text == textModel {
            MainViewController.typingText = "(Swipe back and add something...)"
        } else {
            MainViewController.typingText = typingArea.text
            
            MainViewController.text.replace(title: typingArea.text, dateCreated: Date(timeIntervalSinceNow: 0), isQuestion: true)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.alpha = 1
        if textView.text == textModel {
            textView.text = ""
        }
        if text.contains("\n") {
            hideKeyboard()
            MainViewController.text.replace(title: typingArea.text, dateCreated: Date(timeIntervalSinceNow: 0), isQuestion: true)
            return false
        }
        return true
    }
    
    func hideKeyboard() {
        if typingArea.text == "" {
            typingArea.text = textModel
            typingArea.alpha = 0.3
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
    }
    
    
    @IBAction func createAffair(_ sender: UIButton) {
        if typingArea.text == textModel {
            return
        }
        let createAffair = DoingTableViewController()
        createAffair.addAffair(newAffair: typingArea.text)
        typingArea.text = ""
        hideKeyboard()
    }

    @IBAction func finishAffair(_ sender: UIButton) {
        if typingArea.text == textModel {
            return
        }
        let finishAffair = DoneTableViewController()
        finishAffair.addAffair(newAffair: typingArea.text)
        typingArea.text = ""
        hideKeyboard()
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if let tv = object as? UITextView {
//            var topCorrect: CGFloat? = (tv.bounds.size.height - tv.contentSize.height * tv.zoomScale) / 2.0
//            topCorrect = (topCorrect! < CGFloat(0.0) ? 0.0 : topCorrect)
//            tv.contentOffset = CGPoint()
//            tv.contentOffset.x = 0
//            tv.contentOffset.y = -topCorrect!
//        }
//    }
    
}
