//
//  ConfirmViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/5/30.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var confirmationText: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        viewFrame.backgroundColor = Style.popBackgroundColor
        
        let textColor = Style.mainTextColor
        confirmationText.textColor = Style.mainTextColor
        yesButton.setTitleColor(textColor, for: .normal)
        cancelButton.setTitleColor(textColor, for: .normal)
        
        confirmationText.text = Language.deleteConfirmation
        yesButton.setTitle(Language.yes, for: .normal)
        cancelButton.setTitle(Language.cancel, for: .normal)
        
        showAnimate()
    }
    
    func showAnimate() {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0.0
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
    
    @IBAction func doDelete(_ sender: UIButton) {
        DoneTableViewController.affairs.removeAll()
        DoneTableViewController.modes.removeAll()
        DoneTableViewController.descriptions.removeAll()
        if let doneView = view.superview as? UITableView {
            doneView.reloadData()
        }
        let defaults = UserDefaults.standard
        defaults.set(DoneTableViewController.affairs, forKey: "DoneAffairArray")
        defaults.set(DoneTableViewController.modes, forKey: "DoneModeArray")
        defaults.set(DoneTableViewController.descriptions, forKey: "DescriptionArray")
        removeAnimate()
    }
    
    @IBAction func cancelDelete(_ sender: UIButton) {
        removeAnimate()
    }
    
}
