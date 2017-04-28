//
//  ItemDetailsViewController.swift
//  loginRegister
//
//  Created by Angel Martinez on 4/16/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var viewItemTitle: UILabel!
    @IBOutlet weak var viewItemPrice: UILabel!
    @IBOutlet weak var viewItemTime: UILabel!
    
    var _viewItemTitle:String?
    var _viewItemPrice:Float?
    var _viewItemTime:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewItemPrice.text = "$\(_viewItemPrice!)"
        viewItemTime.text = "\(_viewItemTime!) minutes"
        viewItemTitle.text = _viewItemTitle

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
