//
//  ItemTableViewCell.swift
//  loginRegister
//
//  Created by Abel Morales on 3/23/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class ItemAddTableViewCell: UITableViewCell {
    
    var items = [NSManagedObject]()
    var _menuItem:MenuItem?

    
    func addItem(_itemTitle: String, _itemPrice:Float, _itemTime:Int)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Item", in: managedContext)
        let candidate = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        
        
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

    @IBAction func itemAddBtn(_ sender: Any)
    {
        print(_menuItem?.title)
        print(_menuItem?.price)
        addItem(_itemTitle: (_menuItem?.title)!, _itemPrice: (_menuItem?.price)!, _itemTime: (_menuItem?.time)!)
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
