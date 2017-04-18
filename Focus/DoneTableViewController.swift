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
}
