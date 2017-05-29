//
//  PopUpViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/5/27.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    static var popingUp = false
    
    private let textModel = "Click 'Edit' to add description..."
    var rowNum: Int = 0

    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.showAnimate()
    }
    
    func setThemeColor() {
        viewFrame.backgroundColor = Style.popBackgroundColor
        descriptionText.backgroundColor = Style.cellBackgroundColor
        let textColor = Style.mainTextColor
        descriptionLabel.textColor = textColor
        descriptionText.textColor = textColor
        closeButton.setTitleColor(textColor, for: .normal)
        editButton.setTitleColor(textColor, for: .normal)
    }
    
    func showAnimate() {
        setThemeColor()
        
        PopUpViewController.popingUp = true
        
        descriptionText.text = DoneTableViewController.descriptions[rowNum]
        if descriptionText.text == textModel {
            descriptionText.alpha = 0.3
        }
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableSwipe"), object: nil)
    }
    
    func hideKeyboard() {
        if descriptionText.text == "" {
            descriptionText.text = textModel
            descriptionText.alpha = 0.3
        }
        view.endEditing(true)
    }
    

    
    @IBAction func EnableEdit(_ sender: UIButton) {
        descriptionText.backgroundColor = Style.editTextColor
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
        removeAnimate()
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
        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSwipe"), object: nil)
        PopUpViewController.popingUp = false
    }
}
