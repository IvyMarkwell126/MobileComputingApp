//
//  ItemRemoveTableViewCell.swift
//  loginRegister
//
//  Created by Angel Martinez on 3/24/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

protocol RemoveBtnDelegate {
    func removeItem(passedName:String, passedPrice:Float, passedTime:Int)
}

class ItemRemoveTableViewCell: UITableViewCell {
    
    var btnDelegate:RemoveBtnDelegate?
    var itemName:String?
    var itemPrice:Float?
    var itemTime:Int?
    
    @IBAction func itemRemoveBtn(_ sender: Any) {
        print(index)
        if let delegate = btnDelegate{
            delegate.removeItem(passedName: itemName!, passedPrice: itemPrice!, passedTime: itemTime!)
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
