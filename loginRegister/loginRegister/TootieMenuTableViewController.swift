//
//  MenuTableViewController.swift
//  loginRegister
//
//  Created by Abel Morales on 3/23/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class TootieMenuTableViewController: UITableViewController, UITextFieldDelegate, ItemDetailDelegate {
    
    var idx:Int = 0
    var selectedItem:MenuItem?
    
    private var users:[NSManagedObject] = []
    private var user:NSManagedObject?
    
    private var menuItems:[MenuItem] = []
    private var currentMenu:[MenuItem] = []
    
    private var isVegan:Bool?
    private var isGF:Bool?
    
    @IBOutlet var menuTableView: UITableView!
    private var item:MenuItem?
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMenuItems:[MenuItem] = []
    
    private func createMenuItems(){
        let itClub = MenuItem.init(_title:"Italian Club", _price:7.00, _time:10, _isVeg:false, _isGF:false, _desc: "Salami, Ham, Mortadella, Capicola, Provolone, and Veggies on soft Italian bread")
        let blt = MenuItem.init(_title:"BLT", _price:5.95, _time:7, _isVeg:false, _isGF:false, _desc: "Classic Bacon, Lettuce, and Tomato on white bread")
        let rueben = MenuItem.init(_title:"Rueben", _price:5.95, _time:10, _isVeg:false, _isGF:false, _desc: "Corned Beef, Russian dressing, SauerKraut, and Swiss cheese on Jewish Rye bread")
        let meatball = MenuItem.init(_title:"Meatball", _price:7.00, _time:10, _isVeg:false, _isGF:false, _desc: "Meatballs on bread with cheese, what more do you want?")
        let veggie = MenuItem.init(_title:"Veggie Sandwich", _price:5.95, _time:7, _isVeg:true, _isGF:false, _desc: "Thinly sliced eggplant, zucchini, tomatoes, avocado, and pesto on French bread")
        
        let vegSandwich = MenuItem.init(_title:"Vegan Sandwich", _price:5.95, _time:7, _isVeg:true, _isGF:false, _desc: "An assortment of vegan friendly meat and cheese substitutes on a hoagie roll")
        
        let gfSandich = MenuItem.init(_title: "Gluten Free Sandwich", _price: 4.95, _time: 6, _isVeg:false, _isGF:true, _desc: "Regular menu item with the bread replaced with Gluten free bread or letuce wrap")
        
        let french = MenuItem.init(_title:"French Fries", _price:1.95, _time:3, _isVeg:true, _isGF:true, _desc: "Deep fried french fries made to order")
        let onion = MenuItem.init(_title:"Onion Rings", _price: 2.95, _time: 4, _isVeg:false, _isGF:false, _desc: "Made to order with our secret batter recipe")
        let tator = MenuItem.init(_title: "Tator Tots", _price: 1.95, _time:2, _isVeg:true, _isGF:true, _desc: "Freshly grated tater tots made to order")
        
        let drink = MenuItem.init(_title:"Dr. Pepper", _price:1.50, _time:1, _isVeg:true, _isGF:true, _desc: "King of Beverages")
        let drink2 = MenuItem.init(_title: "Sprite", _price: 1.50, _time: 1, _isVeg:true, _isGF:true, _desc: "Obey Your Thirst")
        let drink3 = MenuItem.init(_title: "Coke", _price: 1.50, _time: 1, _isVeg:true, _isGF:true, _desc: "Open Happiness")
        
        let desert = MenuItem.init(_title:"ChocolateChip Cookie", _price:0.50, _time:1, _isVeg:false, _isGF:false, _desc: "Served warm, soft, and delicious with big chunks of dark chocolate")
        
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
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        
        tableView.keyboardDismissMode = .onDrag
        
        self.tableView.rowHeight = 60.0
        
        idx = 0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        isVegan = user?.value(forKey: "vegan")
            as! Bool?
        
        isGF = user?.value(forKey: "glutenFree")
            as! Bool?
        
        if (isGF! && isVegan!){
            for elt in menuItems {
                if(elt.isGlute && elt.isVegan){
                    currentMenu.append(elt)
                }
            }
        }
            
        else if(isGF! && !isVegan!){
            for elt in menuItems {
                if(elt.isGlute){
                    currentMenu.append(elt)
                }
            }
        }
            
        else if(!isGF! && isVegan!){
            for elt in menuItems {
                if(elt.isVegan){
                    currentMenu.append(elt)
                }
            }
        }
            
        else{
            currentMenu = menuItems
        }

    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredMenuItems = currentMenu.filter { MenuItem in
            return MenuItem.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMenuItems.count
        }
        return currentMenu.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemDetailsTableViewCell", for:indexPath) as! ItemDetailsTableViewCell
            
            if searchController.isActive && searchController.searchBar.text != ""
            {
                cell.itemPrice.text = String(filteredMenuItems[indexPath.section].price)
                cell.itemTitle.text = filteredMenuItems[indexPath.section].title
            }
                
            else{
                
                cell.itemPrice.text = String(currentMenu[indexPath.section].price)
                cell.itemTitle.text = currentMenu[indexPath.section].title
                
            }
            return cell
        }
            
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemAddTableViewCell", for:indexPath) as! ItemAddTableViewCell
            
            // Set the cell menu item object so it can be added as core data item in cart
            if searchController.isActive && searchController.searchBar.text != ""
            {
                cell._menuItem = filteredMenuItems[indexPath.section]
            }
                
            else{
                cell._menuItem = currentMenu[indexPath.section]
            }
            
            if(cell.btnDelegate == nil){
                cell.btnDelegate = self
            }
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
    }
    
    func showDetail(cell: ItemAddTableViewCell) {
        selectedItem = cell._menuItem!
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
            
            viewController.item = selectedItem!
        }

     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchController.searchBar.endEditing(true)
    }
}

extension TootieMenuTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
