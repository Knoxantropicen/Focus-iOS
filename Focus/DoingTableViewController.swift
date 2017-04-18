//
//  DoingTableViewController.swift
//  Focus
//
//  Created by TianKnox on 2017/4/16.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class DoingTableViewController: UITableViewController {
    
    private static var affairs = [Array<String>(), Array<String>()]
    
    func addAffair(newAffair affair: String) {
        let mainAffair = DoingTableViewController.affairs[0]
        if !mainAffair.isEmpty {
            DoingTableViewController.affairs[1].insert(mainAffair.first!, at: 0)
            DoingTableViewController.affairs[0].removeAll()
        }
        DoingTableViewController.affairs[0].append(affair)
//        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DoingTableViewController.affairs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DoingTableViewController.affairs[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoingAffair", for: indexPath)
        let affair = DoingTableViewController.affairs[indexPath.section][indexPath.row]
        if let affairCell = cell as? DoingTableViewCell {
            affairCell.affair = affair
        }
        return cell
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
