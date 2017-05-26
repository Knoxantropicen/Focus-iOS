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
    
    private let defaults = UserDefaults.standard
    
    static var typingText: String = ""
    
    private let textModel = "Start typing here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typingArea.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MainViewController.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if let mainAffairString = UserDefaults.standard.string(forKey: "mainAffairString") {
            MainViewController.typingText = mainAffairString
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
        if typingArea.text == textModel {
            MainViewController.typingText = "(Add something...)"
        } else {
            MainViewController.typingText = typingArea.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.alpha = 1
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
