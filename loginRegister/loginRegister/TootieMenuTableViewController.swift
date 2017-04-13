//
//  MenuTableViewController.swift
//  loginRegister
//
//  Created by Abel Morales on 3/23/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

class TootieMenuTableViewController: UITableViewController {
    
    private var menuItems:[MenuItem] = []
    @IBOutlet var menuTableView: UITableView!
    
    private func createMenuItems()
    {
        let itClub = MenuItem.init(_title:"Italian Club", _price:7.00, _time:10)
        let blt = MenuItem.init(_title:"BLT", _price:5.95, _time:7)
        let rueben = MenuItem.init(_title:"Rueben", _price:5.95, _time:10)
        let meatball = MenuItem.init(_title:"Meatball", _price:7.00, _time:10)
        let veggie = MenuItem.init(_title:"Veggie Sandwich", _price:5.95, _time:7)
        
        let french = MenuItem.init(_title:"French Fries", _price:1.95, _time:3)
        let onion = MenuItem.init(_title:"Onion Rings", _price: 2.95, _time: 4)
        let tator = MenuItem.init(_title: "Tator Tots", _price: 1.95, _time:2)
        
        let drink = MenuItem.init(_title:"Dr. Pepper", _price:1.50, _time:1)
        let drink2 = MenuItem.init(_title: "Sprite", _price: 1.50, _time: 1)
        let drink3 = MenuItem.init(_title: "Coke", _price: 1.50, _time: 1)
        
        let desert = MenuItem.init(_title:"ChocolateChip Cookie", _price:0.50, _time:1)
        
        menuItems.append(itClub)
        menuItems.append(blt)
        menuItems.append(meatball)
        menuItems.append(rueben)
        menuItems.append(veggie)
        menuItems.append(french)
        menuItems.append(onion)
        menuItems.append(tator)
        menuItems.append(drink)
        menuItems.append(drink2)
        menuItems.append(drink3)
        menuItems.append(desert)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMenuItems()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        if(indexPath.row % 2 == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemDetailsTableViewCell", for:indexPath) as! ItemDetailsTableViewCell
            
            cell.itemPrice.text = String(menuItems[indexPath.section].price)
            cell.itemTitle.text = menuItems[indexPath.section].title
            
            return cell
        }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemAddTableViewCell", for:indexPath) as! ItemAddTableViewCell
            cell._menuItem = menuItems[indexPath.section]
            
            return cell
        }
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
