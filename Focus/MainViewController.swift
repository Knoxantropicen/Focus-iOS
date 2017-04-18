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
    
    static var typingText: String = ""
    
    private let textModel = "Type your sentence here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typingArea.delegate = self
//        typingArea.becomeFirstResponder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MainViewController.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if typingArea.text == textModel {
            MainViewController.typingText = "(Swipe right and add something...)"
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
        view.endEditing(true)
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

    
}
