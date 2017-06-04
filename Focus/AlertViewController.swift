//
//  AlertViewController.swift
//  Focuson
//
//  Created by TianKnox on 2017/6/1.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var alertText: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        viewFrame.backgroundColor = Style.popBackgroundColor
        
        let textColor = Style.mainTextColor
        alertText.textColor = Style.mainTextColor
        yesButton.setTitleColor(textColor, for: .normal)
        cancelButton.setTitleColor(textColor, for: .normal)
        
        alertText.text = Language.replaceAlert
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
    
    @IBAction func doReplace(_ sender: UIButton) {
        let replaceText = DoingTableViewController.affairs.remove(at: 0)
        let replaceMode = DoingTableViewController.modes.remove(at: 0)
        if let doingView = view.superview as? UITableView {
            doingView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: UITableViewRowAnimation.bottom)
            doingView.reloadData()
        }
        let defaults = UserDefaults.standard
        defaults.set(DoingTableViewController.affairs, forKey: "DoingAffairArray")
        defaults.set(DoingTableViewController.modes, forKey: "DoingModeArray")
        
        defaults.set(true, forKey: "outerReplaced")
        defaults.set(replaceText, forKey: "mainAffairString")
        if replaceMode == "?" {
            MainViewController.isQuestion = true
        } else {
            MainViewController.isQuestion = false
        }
        defaults.set(!MainViewController.isQuestion, forKey: "mainModeRevBool")
        removeAnimate()
    }
    
    @IBAction func cancelReplace(_ sender: UIButton) {
        removeAnimate()
    }
    
}
