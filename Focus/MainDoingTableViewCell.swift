//
//  MainDoingTableViewCell.swift
//  Focus
//
//  Created by TianKnox on 2017/4/17.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class MainDoingTableViewCell: UITableViewCell {

    @IBOutlet weak var mainAffairDescription: UILabel!
    
    var mainAffair = String() {
        didSet {
            mainAffairDescription?.text = mainAffair
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
