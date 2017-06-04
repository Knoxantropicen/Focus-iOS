//
//  DoingTableViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/16.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class DoingTableViewController: UITableViewController {
    
    static var affairs = Array<String>()
    static var modes = Array<String>()
    
    private let defaults = UserDefaults.standard
    
    func addAffair(newAffair affair: String, newMode mode: String) {
        DoingTableViewController.affairs.insert(affair, at: 0)
        DoingTableViewController.modes.insert(mode, at: 0)
        defaults.set(DoingTableViewController.affairs, forKey: "DoingAffairArray")
        defaults.set(DoingTableViewController.modes, forKey: "DoingModeArray")
    }
    
    func deleteAffair(deletingAffair index: Int) {
        let doneTable = DoneTableViewController()
        doneTable.addAffair(newAffair: DoingTableViewController.affairs.remove(at: index), newMode: DoingTableViewController.modes.remove(at: index))
        defaults.set(DoingTableViewController.affairs, forKey: "DoingAffairArray")
        defaults.set(DoingTableViewController.modes, forKey: "DoingModeArray")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(DoingTableViewController.longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
        tableView.alwaysBounceVertical = false
        tableView.separatorColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        view.backgroundColor = Style.mainBackgroundColor
    }
    
    @IBAction func returnAffair(_ sender: UIButton) {
        if DoingTableViewController.affairs.count == 0 {
            return
        }
        if defaults.string(forKey: "mainAffairString") == Language.mainModel {
            let replaceText = DoingTableViewController.affairs.remove(at: 0)
            let replaceMode = DoingTableViewController.modes.remove(at: 0)
            tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: UITableViewRowAnimation.bottom)
            tableView.reloadData()
            defaults.set(DoingTableViewController.affairs, forKey: "DoingAffairArray")
            defaults.set(DoingTableViewController.modes, forKey: "DoingModeArray")
            
            defaults.set(true, forKey: "outerReplaced")
            defaults.set(replaceText, forKey: "mainAffairString")
            UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(replaceText, forKey: "mainAffairString")
            UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(replaceMode, forKey: "mainAffairMode")
            if replaceMode == "?" {
                MainViewController.isQuestion = true
            } else {
                MainViewController.isQuestion = false
            }
            defaults.set(!MainViewController.isQuestion, forKey: "mainModeRevBool")
            UserDefaults(suiteName: "group.knox.Focuson.extension")?.set(!MainViewController.isQuestion, forKey: "mainModeRevBool")
            return
        }
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: locationInView)
        
        struct My {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.began:
            if indexPath != nil && indexPath?.section != 0 {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
                My.cellSnapshot  = snapshotOfCell(cell!)
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                tableView.addSubview(My.cellSnapshot!)
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            cell?.isHidden = true
                        }
                    }
                })
            }
            
        case UIGestureRecognizerState.changed:
            if My.cellSnapshot != nil {
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                if (center.y < tableView.rect(forSection: 0).height) {
                    break
                }
                My.cellSnapshot!.center = center
                
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    DoingTableViewController.affairs.insert(DoingTableViewController.affairs.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    DoingTableViewController.modes.insert(DoingTableViewController.modes.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                    Path.initialIndexPath = indexPath
                }
            }
        default:
            if Path.initialIndexPath != nil {
                let cell = tableView.cellForRow(at: Path.initialIndexPath!) as UITableViewCell!
                if My.cellIsAnimating {
                    My.cellNeedToShow = true
                } else {
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                }
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell?.center)!
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                    
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                        self.tableView.reloadData()
                    }
                })
//                self.tableView.reloadData()
            }
        }
    }

    
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return DoingTableViewController.affairs.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let mainCell = tableView.dequeueReusableCell(withIdentifier: "MainAffair", for: indexPath)
            mainCell.backgroundColor = Style.tableBackgroundColor
            for subView in mainCell.contentView.subviews {
                if let textLabelView = subView as? UILabel {
                    textLabelView.textColor = Style.mainTextColor
                    if textLabelView.text != "" {
                        textLabelView.text = Language.doing
                    }
                }
                if let buttonView = subView as? UIButton {
                    buttonView.setImage(Style.returnIcon, for: .normal)
                }
            }
            return mainCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoingAffair", for: indexPath) as! MGSwipeTableCell
            let affair = DoingTableViewController.affairs[indexPath.row]
            let mode = DoingTableViewController.modes[indexPath.row]
            if let affairCell = cell as? DoingTableViewCell {
                affairCell.affair = affair
                affairCell.settledMode.setTitle(mode, for: .normal)
            }
            cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named: "doublecheck.png"), backgroundColor: UIColor.green.withAlphaComponent(Style.optionAlpha), padding: 20, callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                self.deleteAffair(deletingAffair: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
                self.tableView.reloadData()
                return true
            })]
            
            cell.leftSwipeSettings.transition = .border
            cell.leftExpansion.buttonIndex = 0
            cell.leftExpansion.fillOnTrigger = true
            cell.leftExpansion.animationDuration = 0.5
            cell.backgroundColor = Style.cellBackgroundColor
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
