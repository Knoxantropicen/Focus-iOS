//
//  DoneTableViewCell.swift
//  Focus
//
//  Created by TianKnox on 2017/4/18.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

class DoneTableViewCell: MGSwipeTableCell {
    
    @IBOutlet weak var affairDescription: UILabel!
    
    var affair = String() {
        didSet {
            affairDescription?.text = affair
        }
    }
    
    @IBOutlet weak var settledMode: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
