//
//  PreviewTableViewController.swift
//  loginRegister
//
//  Created by Angel Martinez on 3/24/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class PreviewTableViewController: UITableViewController, RemoveBtnDelegate {
    
    var idx = 0
    
    var users = [NSManagedObject]()
    var cart = [NSManagedObject]()
    
    var hoursAlert:UIAlertController? = nil
    
    var totalPrice:Float = 0
    var totalTime:Int = 0
    var completeOrder:String = ""
    var order:String = ""
    var price:String = ""
    var time:String = ""
    
    @IBOutlet var previewTable: UITableView!
    
    @IBOutlet weak var previewTotal: UILabel!
    
    @IBAction func confirmOrderBtn(_ sender: Any)
    {
        // Delete the items in the cart (core data) so they do not persist in an additional order
        // Will segue to ConfirmationViewController, which has the item details
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // Hours alert controller - if we are closed!
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        //let hour = 15
        let minute = calendar.component(.minute, from: date)
        print("check time")
        print(hour)
        
        if(hour < 10 || hour > 18){
            hoursAlert = UIAlertController(title: "Sorry!", message: "We are closed!", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                //print("Ok Button Pressed 1");
            }
            hoursAlert!.addAction(OKAction)
            present(self.hoursAlert!, animated: true, completion:nil)
        }
        
        else{
            do{
                try persistentContainer.viewContext.execute(deleteRequest)
            }
                
            catch let error as NSError{
                print(error)
            }
            registerOrder(completeOrder:completeOrder)
            performSegue(withIdentifier: "ConfirmOrderSegue", sender: nil)
        }
        

    }
    
    func registerOrder(completeOrder:String){
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
                order += completeOrder
                price += String(totalPrice) + " "
                time += String(totalTime) + " "
                
                elt.setValue(order, forKey: "pastOrder")
                elt.setValue(price, forKey: "pastPrice")
                elt.setValue(time, forKey: "pastTimes")
                do {
                    try managedContext.save()
                } catch {
                    // what to do if an error occurs?
                    let nserror = error as NSError
                    print("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
        }
    }

    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            cart = results
        } else {
            print("Could not fetch")
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60.0
        loadData()
        for elt in cart{
            var testName = (elt.value(forKey: "title") as? String)!
            var testPrice = (elt.value(forKey: "price") as? Float)!
            var testTime = (elt.value(forKey: "time") as? Int)!
            print ("\(testPrice) \(testTime)")
            
            totalPrice += testPrice
            totalTime += testTime
            completeOrder += testName + "-"
            
        }
        completeOrder = String(completeOrder.characters.dropLast())
        completeOrder += ";"

        previewTotal.text = String(totalPrice)
        
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
        return cart.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //reuse ids: itemPreviewTableViewCell, itemRemoveTableViewCell
        
        if(indexPath.row % 2 == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemPreviewTableViewCell", for:indexPath) as! ItemPreviewTableViewCell
            cell.titlePreview.text = (cart[indexPath.section].value(forKey: "title") as? String)!
            cell.itemPricePreview.text = String((cart[indexPath.section].value(forKey: "price") as? Float)!)
            return cell
        }
        
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemRemoveTableViewCell") as! ItemRemoveTableViewCell
            cell.itemName = cart[indexPath.section].value(forKey: "title") as? String
            cell.itemTime = cart[indexPath.section].value(forKey: "time") as? Int
            cell.itemPrice = cart[indexPath.section].value(forKey: "price") as? Float
            idx += 1
            if(cell.btnDelegate == nil){
                cell.btnDelegate = self
            }
            return cell
        }

    }
    
    func removeItem(passedName: String, passedPrice: Float, passedTime: Int) {
        var index = 0
        
        for elt in cart {
            if elt.value(forKey: "title") as? String == passedName {
                print(index, cart.count)
                cart.remove(at: index)
                totalTime -= (elt.value(forKey: "time") as? Int)!
                totalPrice -= (elt.value(forKey: "price") as? Float)!
                break
            }
            index += 1
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        do{
            try persistentContainer.viewContext.execute(deleteRequest)
        }
        catch let error as NSError{
            print(error)
        }
        
        for elt in cart{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entity =  NSEntityDescription.entity(forEntityName: "Item", in: managedContext)
            let candidate = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            // Storing data in core data
            // be sure to add .setValue for any new attributes that need to be added
            
            candidate.setValue((elt.value(forKey: "title") as? String)!, forKey: "title")
            candidate.setValue((elt.value(forKey: "price") as? Float)!, forKey: "price")
            candidate.setValue((elt.value(forKey: "time") as? Int)!, forKey: "time")
            
            do {
                try managedContext.save()
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }

        }
        
        print("Deteted whole cart")
        
        /*
        print("lksdfj;lakdjs")
        print(removeIdx)
        var toBeRemoved = cart[removeIdx]
        cart.remove(at: removeIdx)
        idx = 0
        totalPrice -= (toBeRemoved.value(forKey: "price") as? Float)!
        previewTotal.text = String(totalPrice)
        totalTime -= (toBeRemoved.value(forKey: "time") as? Int)!
                                    */
        previewTotal.text = String(totalPrice)
        self.tableView.reloadData()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ConfirmOrderSegue")
        {
            // Pass the items in the cart to the ConfirmationViewController to show
            // total time and dollar amount
            
            let viewController = segue.destination as! ConfirmationViewController
            viewController._orderTotal = String(totalPrice)
            viewController._orderTime = String(totalTime)
        }
    }
}
