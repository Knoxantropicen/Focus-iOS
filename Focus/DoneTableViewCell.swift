//
//  DoneTableViewCell.swift
//  Focus
//
//  Created by TianKnox on 2017/4/18.
//  Copyright © 2017年 TianKnox. All rights reserved.
//

import UIKit


class DoneTableViewCell: MGSwipeTableCell, MGSwipeTableCellDelegate {
    
    @IBOutlet weak var affairDescription: UILabel!
    
    var affair = String() {
        didSet {
            affairDescription?.text = affair
            affairDescription?.textColor = Style.mainTextColor
            settledMode.setTitleColor(Style.symbolColor, for: .normal)
        }
    }
    
    @IBOutlet weak var settledMode: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    }
}
