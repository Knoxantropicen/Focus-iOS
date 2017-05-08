//
//  DoingTableViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/16.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class DoingTableViewController: UITableViewController {
    
    private static var affairs = Array<String>()
    
    func addAffair(newAffair affair: String) {
        DoingTableViewController.affairs.insert(affair, at: 0)
    }
    
    func deleteAffair(deletingAffair index: Int) {
        let doneTable = DoneTableViewController()
        doneTable.addAffair(newAffair: DoingTableViewController.affairs.remove(at: index))
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
            return DoingTableViewController.affairs.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoingAffair", for: indexPath) as! MGSwipeTableCell
            let affair = DoingTableViewController.affairs[indexPath.row]
            if let affairCell = cell as? DoingTableViewCell {
                affairCell.affair = affair
            }
            cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named: "check.png"), backgroundColor: .green, padding: 20, callback: {
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
//            cell.allowsMultipleSwipe = true;
//            cell.allowsOppositeSwipe = false;
            return cell
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
    
    @IBOutlet weak var mainMode: UILabel!
    
    func changeMainMode(_ mainModeText:String) {
        mainMode.text = mainModeText
    }
    
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            DoingTableViewController.affairs[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete", handler: { (action: UITableViewRowAction, index: IndexPath) in
//            DoingTableViewController.affairs[indexPath.section].remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//        })
//        let actions = [deleteRowAction]
//        return actions
//    }

}
