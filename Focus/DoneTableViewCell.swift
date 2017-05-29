//
//  DoneTableViewCell.swift
//  Focus
//
//  Created by TianKnox on 2017/4/18.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class DoneTableViewCell: MGSwipeTableCell {
=======
class DoneTableViewCell: MGSwipeTableCell, MGSwipeTableCellDelegate {
>>>>>>> Test commit
    
    @IBOutlet weak var affairDescription: UILabel!
    
    var affair = String() {
        didSet {
            affairDescription?.text = affair
<<<<<<< HEAD
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
=======
            affairDescription?.textColor = Style.mainTextColor
            settledMode.setTitleColor(Style.symbolColor, for: .normal)
        }
    }
    
    @IBOutlet weak var settledMode: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
>>>>>>> Test commit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
<<<<<<< HEAD

        // Configure the view for the selected state
=======
    }
    
    func swipeTableCellWillBeginSwiping(_ cell: MGSwipeTableCell) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableSwipe"), object: nil)
    }
    
    func swipeTableCellWillEndSwiping(_ cell: MGSwipeTableCell) {
        if !PopUpViewController.popingUp {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSwipe"), object: nil)
        }
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
>>>>>>> Test commit
    }
}
