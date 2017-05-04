//
//  ItemTableViewCell.swift
//  loginRegister
//
//  Created by Abel Morales on 3/23/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

protocol ItemDetailDelegate {
    func showDetail(cell:ItemAddTableViewCell)
}

// View cell for adding items in the menu table  
class ItemAddTableViewCell: UITableViewCell {
    
    var btnDelegate:ItemDetailDelegate?
    
    var items = [NSManagedObject]()
    var _menuItem:MenuItem?
    var rowIndex:Int?

    // Storing cart items in core data
    func addItem(_itemTitle: String, _itemPrice:Float, _itemTime:Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Item", in: managedContext)
        let candidate = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Storing data in core data
        // be sure to add .setValue for any new attributes that need to be added
        
        candidate.setValue(_itemTitle, forKey: "title")
        candidate.setValue(_itemPrice, forKey: "price")
        candidate.setValue(_itemTime, forKey: "time")
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }

    @IBAction func itemAddBtn(_ sender: Any){
        // Will add the selected item to the session cart
        addItem(_itemTitle: (_menuItem?.title)!, _itemPrice: (_menuItem?.price)!, _itemTime: (_menuItem?.time)!)
    }
    
    @IBAction func itemDetailsBtn(_ sender: Any) {
        if let delegate = btnDelegate{
            delegate.showDetail(cell: self)
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
