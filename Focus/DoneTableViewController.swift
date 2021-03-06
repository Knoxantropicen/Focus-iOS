//
//  DoneTableViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/16.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class DoneTableViewController: UITableViewController {

    static var affairs = Array<String>()
    static var modes = Array<String>()
    static var descriptions = Array<String>()
    
    private let defaults = UserDefaults.standard
    
    func setDefaults() {
        defaults.set(DoneTableViewController.affairs, forKey: "DoneAffairArray")
        defaults.set(DoneTableViewController.modes, forKey: "DoneModeArray")
        defaults.set(DoneTableViewController.descriptions, forKey: "DescriptionArray")
    }
    
    func addAffair(newAffair affair: String, newMode mode: String) {
        DoneTableViewController.affairs.insert(affair, at: 0)
        DoneTableViewController.modes.insert(mode, at: 0)
        DoneTableViewController.descriptions.insert(Language.editModel, at: 0)
        setDefaults()
    }
    
    func deleteAffair(deletingAffair index: Int) {
        DoneTableViewController.affairs.remove(at: index)
        DoneTableViewController.modes.remove(at: index)
        DoneTableViewController.descriptions.remove(at: index)
        setDefaults()
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
                    DoneTableViewController.affairs.insert(DoneTableViewController.affairs.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    DoneTableViewController.modes.insert(DoneTableViewController.modes.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    DoneTableViewController.descriptions.insert(DoneTableViewController.descriptions.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    setDefaults()
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
    
    func showPopUp(rowNum: Int) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        popOverVC.rowNum = rowNum
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showConfirmation(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmViewController") as! ConfirmViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return DoneTableViewController.affairs.count
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
                        textLabelView.text = Language.done
                    }
                }
                if let buttonView = subView as? UIButton {
                    buttonView.setImage(Style.deleteIcon, for: .normal)
                }
            }
            return mainCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoneAffair", for: indexPath) as! MGSwipeTableCell
            let affair = DoneTableViewController.affairs[indexPath.row]
            let mode = DoneTableViewController.modes[indexPath.row]
            if let affairCell = cell as? DoneTableViewCell {
                affairCell.affair = affair
                affairCell.settledMode.setTitle(mode, for: .normal)
            }
            cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named: "delete.png"), backgroundColor: UIColor.red.withAlphaComponent(Style.optionAlpha), padding: 20, callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                self.deleteAffair(deletingAffair: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
                self.tableView.reloadData()
                return true
            }), MGSwipeButton(title: "", icon: UIImage(named: "more.png"), backgroundColor: UIColor.lightGray.withAlphaComponent(Style.optionAlpha), padding: 20, callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                self.showPopUp(rowNum: indexPath.row)
                return true
            })]
            cell.rightSwipeSettings.transition = .border
            cell.rightExpansion.threshold = 0.5
            cell.backgroundColor = Style.cellBackgroundColor
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
