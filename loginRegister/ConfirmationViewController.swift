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
    
    var _orderTotal:Float = 0
    var _orderTime:Int = 0

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
