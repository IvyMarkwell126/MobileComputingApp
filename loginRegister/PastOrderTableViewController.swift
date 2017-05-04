//
//  PastOrderTableViewController.swift
//  loginRegister
//
//  Created by Angel Martinez on 4/11/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class PastOrderTableViewController: UITableViewController, DetailBtnDelegate {
    
    var idx:Int = 0
    var referenceIndex = 0
    
    var users = [NSManagedObject]()
    var orders:[String] = []
    var order:String = ""
    var price:String = ""
    var prices:[String] = []
    var time:String = ""
    var times:[String] = []
    var regisAlert:UIAlertController? = nil
    
    @IBOutlet var pastOrders: UITableView!
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let usernameFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        var fetchedUser:[NSManagedObject]? = nil
        
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
            users = results
        } else {
            print("Could not fetch")
        }
        
        for elt in users {
            let testName = (elt.value(forKey: "loggedIn") as? Bool)!
            if testName {
                if (elt.value(forKey: "pastOrder") == nil) {
                    order = ""
                }
                else {
                    order = elt.value(forKey: "pastOrder") as! String
                    price = elt.value(forKey: "pastPrice") as! String
                    time = elt.value(forKey: "pastTimes") as! String
                }
            }
        }
        orders = order.components(separatedBy: ";")
        prices = price.components(separatedBy: " ")
        times = time.components(separatedBy: " ")
        orders.popLast()
        prices.popLast()
        times.popLast()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
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
        var rows = orders.count
        if(rows > 3){
            rows = 3
        }
        else if(rows == 0){
            rows = 1
        }
        return rows
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"OrderViewCell", for:indexPath) as! OrderViewCell
        
        if(cell.btnDelegate == nil){
            cell.btnDelegate = self
        }
        
        if (orders.count == 0) {
            cell.itemList.text = "You don't have any orders yet!"
            cell.itemPrice.text = ""
        }
        if (orders.count == 1) {
            if indexPath.section == 0 {
                cell.itemList.text = orders[0].replacingOccurrences(of: "-", with: "\n")
                cell.itemPrice.text = prices[0]
            }
            else {
                cell.itemList.text = "You don't have any orders yet!"
                cell.itemPrice.text = ""
            }
        }
        if (orders.count == 2) {
            if indexPath.section == 0 {
                cell.itemList.text = orders[1].replacingOccurrences(of: "-", with: "\n")
                cell.itemPrice.text = prices[1]
            }
            if indexPath.section == 1 {
                cell.itemList.text = orders[0].replacingOccurrences(of: "-", with: "\n")
                cell.itemPrice.text = prices[0]
            }
            if indexPath.section == 2 {
                cell.itemList.text = "You don't have any orders yet!"
                cell.itemPrice.text = ""
            }
        }
        if (orders.count >= 3) {
            var index = orders.count - indexPath.section - 1
            cell.itemList.text = orders[index].replacingOccurrences(of: "-", with: "\n")
            cell.itemPrice.text = prices[index]
        }
        idx += 1
        cell.rowIndex = idx - 1
        return cell
        

    }
    
    func showAlert(cell: OrderViewCell) {
        referenceIndex = (-1*cell.rowIndex!)+(orders.count-1)
        performSegue(withIdentifier: "reorder2confirm", sender: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        //let hour = 15
        let minute = calendar.component(.minute, from: date)
        
        if(hour < 10 || hour > 18)
        {
            self.regisAlert = UIAlertController(title: "Sorry!", message: "We are closed!", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            }
            self.regisAlert!.addAction(OKAction)
            self.present(self.regisAlert!, animated: true, completion:nil)
        }
        
        if(segue.identifier == "reorder2confirm")
        {
            let viewController = segue.destination as! ConfirmationViewController

            if (self.referenceIndex < 0) {
                self.regisAlert = UIAlertController(title: "Error", message: "You don't have any orders yet!", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                }
                self.regisAlert!.addAction(OKAction)
                self.present(self.regisAlert!, animated: true, completion:nil)
            }
            else {
                viewController._orderTotal = self.prices[self.referenceIndex]
                viewController._orderTime = self.times[self.referenceIndex]
            }
        }
    }
}
