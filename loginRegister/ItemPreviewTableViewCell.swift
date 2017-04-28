//
//  ItemPreviewTableViewCell.swift
//  loginRegister
//
//  Created by Angel Martinez on 3/24/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

class ItemPreviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlePreview: UILabel!
    
    @IBOutlet weak var itemPricePreview: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
