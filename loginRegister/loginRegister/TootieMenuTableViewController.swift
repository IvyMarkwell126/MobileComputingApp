//
//  MenuTableViewController.swift
//  loginRegister
//
//  Created by Abel Morales on 3/23/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class TootieMenuTableViewController: UITableViewController, ItemDetailDelegate {
    
    var idx:Int = 0
    var selectedIndex = 0
    
    private var users:[NSManagedObject] = []
    private var user:NSManagedObject?
    
    private var menuItems:[MenuItem] = []
    //private var veganItems:[MenuItem] = []
    //private var gfItems:[MenuItem] = []
    private var currentMenu:[MenuItem] = []
    
    private var isVegan:Bool?
    private var isGF:Bool?
    
    @IBOutlet var menuTableView: UITableView!
    private var item:MenuItem?
    
    private func createMenuItems()
    {
        let itClub = MenuItem.init(_title:"Italian Club", _price:7.00, _time:10, _isVeg:false, _isGF:false)
        let blt = MenuItem.init(_title:"BLT", _price:5.95, _time:7, _isVeg:false, _isGF:false)
        let rueben = MenuItem.init(_title:"Rueben", _price:5.95, _time:10, _isVeg:false, _isGF:false)
        let meatball = MenuItem.init(_title:"Meatball", _price:7.00, _time:10, _isVeg:false, _isGF:false)
        let veggie = MenuItem.init(_title:"Veggie Sandwich", _price:5.95, _time:7, _isVeg:false, _isGF:false)
        
        let vegSandwich = MenuItem.init(_title:"Vegan Sandwich", _price:5.95, _time:7, _isVeg:true, _isGF:false)
        
        let gfSandich = MenuItem.init(_title: "Gluten Free Sandwich", _price: 4.95, _time: 6, _isVeg:false, _isGF:true)
        
        let french = MenuItem.init(_title:"French Fries", _price:1.95, _time:3, _isVeg:true, _isGF:true)
        let onion = MenuItem.init(_title:"Onion Rings", _price: 2.95, _time: 4, _isVeg:false, _isGF:false)
        let tator = MenuItem.init(_title: "Tator Tots", _price: 1.95, _time:2, _isVeg:true, _isGF:true)
        
        let drink = MenuItem.init(_title:"Dr. Pepper", _price:1.50, _time:1, _isVeg:true, _isGF:true)
        let drink2 = MenuItem.init(_title: "Sprite", _price: 1.50, _time: 1, _isVeg:true, _isGF:true)
        let drink3 = MenuItem.init(_title: "Coke", _price: 1.50, _time: 1, _isVeg:true, _isGF:true)
        
        let desert = MenuItem.init(_title:"ChocolateChip Cookie", _price:0.50, _time:1, _isVeg:false, _isGF:false)
        
        menuItems.append(itClub)
        menuItems.append(blt)
        menuItems.append(meatball)
        menuItems.append(rueben)
        menuItems.append(veggie)
        menuItems.append(vegSandwich)
        menuItems.append(gfSandich)
        menuItems.append(french)
        menuItems.append(onion)
        menuItems.append(tator)
        menuItems.append(drink)
        menuItems.append(drink2)
        menuItems.append(drink3)
        menuItems.append(desert)
    }
    
    func loginCheck(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let usernameFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        var fetchedUser:[NSObject]?
        
        do {
            try fetchedUser = managedContext.fetch(usernameFetch) as? [NSManagedObject]//! [loggedIn]
        }
        catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        if let results = fetchedUser {
            users = results as! [NSManagedObject]
            print("\(users.count)")
        } else {
            print("Could not fetch")
        }
        
        for elt in users {
            let isLoggedIn = (elt.value(forKey: "loggedIn") as? Bool)!
            if isLoggedIn {
                
                user = elt
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMenuItems()
        loginCheck()
        self.tableView.rowHeight = 60.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        isVegan = user?.value(forKey: "vegan")
            as! Bool?
        
        isGF = user?.value(forKey: "glutenFree")
            as! Bool?
        
        print("User is Vegan: " + String(describing: isVegan!))
        print("User is Gluten Free: " + String(describing: isGF!))
        
        //print(isGF)
        //print(isVegan)
        
        if (isGF! && isVegan!)
        {
            for elt in menuItems {
                if(elt.isGlute && elt.isVegan){
                    currentMenu.append(elt)
                }
            }
        }
            
        else if(isGF! && !isVegan!)
        {
            for elt in menuItems {
                if(elt.isGlute){
                    currentMenu.append(elt)
                }
            }
        }
            
        else if(!isGF! && isVegan!)
        {
            for elt in menuItems {
                if(elt.isVegan){
                    currentMenu.append(elt)
                }
            }
        }
            
        else
        {
            currentMenu = menuItems
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return currentMenu.count
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
            
            cell.itemPrice.text = String(currentMenu[indexPath.section].price)
            cell.itemTitle.text = currentMenu[indexPath.section].title
            
            return cell
        }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemAddTableViewCell", for:indexPath) as! ItemAddTableViewCell
            
            // Set the cell menu item object so it can be added as core data item in cart
            cell._menuItem = currentMenu[indexPath.section]
            
            if(cell.btnDelegate == nil){
                cell.btnDelegate = self
            }
            
            idx += 1
            cell.rowIndex = idx - 1
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        
        //item = currentCell._menuItem
        //valueToPass = currentCell. item object to pass
        //performSegueWithIdentifier("yourSegueIdentifer", sender: self)
    }
    
    
    func showAlert(cell: ItemAddTableViewCell) {
        selectedIndex = cell.rowIndex!
        performSegue(withIdentifier: "menu2details", sender: nil)
    }
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if(segue.identifier == "menu2details")
        {
            // Pass the items in the cart to the ConfirmationViewController to show
            // total time and dollar amount
            let viewController = segue.destination as! ItemDetailsViewController
            viewController._viewItemTitle = menuItems[selectedIndex].title
            viewController._viewItemTime = menuItems[selectedIndex].time
            viewController._viewItemPrice = menuItems[selectedIndex].price
        }

     }
     
    
}
