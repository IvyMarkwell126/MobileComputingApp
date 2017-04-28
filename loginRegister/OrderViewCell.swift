//
//  OrderViewCell.swift
//  loginRegister
//
//  Created by Angel Martinez on 4/11/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

protocol DetailBtnDelegate {
    func showAlert(cell:OrderViewCell)
}

class OrderViewCell: UITableViewCell {
    var btnDelegate:DetailBtnDelegate?
    
    var rowIndex:Int?

    @IBOutlet weak var itemList: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func reOrderBtn(_ sender: Any) {
        if let delegate = btnDelegate{
            delegate.showAlert(cell: self)
        }
    }
}
