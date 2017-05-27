//
//  PopUpViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/5/27.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    private let textModel = "Click 'Edit' to add description..."
    var rowNum: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.showAnimate()
    }
    
    func showAnimate() {
        descriptionText.text = DoneTableViewController.descriptions[rowNum]
        if descriptionText.text == textModel {
            descriptionText.alpha = 0.3
        }
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
//        PageViewController.popingUp = true
//        let pageView = PageViewController()
//        pageView.changeScrollState()
    }
    
    func hideKeyboard() {
        if descriptionText.text == "" {
            descriptionText.text = textModel
            descriptionText.alpha = 0.3
        }
        view.endEditing(true)
    }
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBAction func EnableEdit(_ sender: UIButton) {
        descriptionText.backgroundColor = UIColor.white
        descriptionText.isEditable = true
        descriptionText.becomeFirstResponder()
        descriptionText.alpha = 1
        if descriptionText.text == textModel {
            descriptionText.selectedTextRange = descriptionText.textRange(from: descriptionText.beginningOfDocument, to: descriptionText.endOfDocument)
        } else {
            descriptionText.selectedRange = NSRange(location: descriptionText.text.lengthOfBytes(using: .utf8), length: 0)
        }
    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
        descriptionText.isEditable = false
        DoneTableViewController.descriptions[rowNum] = descriptionText.text
        self.removeAnimate()
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
            self.descriptionText.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        });
//        PageViewController.popingUp = false
//        let pageView = PageViewController()
//        pageView.changeScrollState()
    }
}
