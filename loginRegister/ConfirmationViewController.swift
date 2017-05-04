//
//  ConfirmationViewController.swift
//  loginRegister
//
//  Created by Angel Martinez on 3/24/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var orderTotal: UILabel!
    
    @IBOutlet weak var orderTime: UILabel!
    
    var _orderTotal:String = ""
    var _orderTime:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        orderTime.text = "\(_orderTime) minutes"
        orderTotal.text = "$\(_orderTotal)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
