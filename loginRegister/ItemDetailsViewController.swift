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
    @IBOutlet weak var viewItemDesc: UILabel!
    
    var item:MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewItemPrice.text = "$\((item?.price)!)"
        viewItemTime.text = "\((item?.time)!) minutes"
        viewItemTitle.text = item?.title
        viewItemDesc.text = item?.desc

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destVC = segue.destination as! CommentsTableViewController
        destVC.itemName = item?.title
    }
}
