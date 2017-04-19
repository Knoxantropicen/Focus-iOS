//
//  DoneTableViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/16.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class DoneTableViewController: UITableViewController {

    private static var affairs = Array<String>()
    
    func addAffair(newAffair affair: String) {
        DoneTableViewController.affairs.insert(affair, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
            let mainAffair = MainViewController.typingText
            if let mainAffairCell = mainCell as? MainTableViewCell {
                mainAffairCell.mainAffair = mainAffair
            }
            return mainCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoneAffair", for: indexPath)
            let affair = DoneTableViewController.affairs[indexPath.row]
            if let affairCell = cell as? DoneTableViewCell {
                affairCell.affair = affair
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            DoneTableViewController.affairs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        }
        else {
            return 68
        }
    }
    
//        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//            if indexPath.section == 0 {
//                return
//            }
//            if editingStyle == .delete {
//                DoneTableViewController.affairs.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
//            }
//        }
//    
//        override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//            if indexPath.section == 0 {
//                return nil
//            }
//            let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete", handler: { (action: UITableViewRowAction, index: IndexPath) in
//                DoneTableViewController.affairs.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            })
//            let actions = [deleteRowAction]
//            return actions
//        }
}
