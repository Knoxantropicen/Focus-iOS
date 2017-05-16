//
//  MainDoingTableViewCell.swift
//  Focus
//
//  Created by TianKnox on 2017/4/18.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var mainAffairDescription: UILabel!
    
    var mainAffair = String() {
        didSet {
            mainAffairDescription?.text = mainAffair
        }
    }
    
    
    @IBOutlet weak var mainMode: UIButton!
    
    func changeState() {
        if MainViewController.isQuestion {
            mainMode.setTitle("?", for: .normal)
        } else {
            mainMode.setTitle("!", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
