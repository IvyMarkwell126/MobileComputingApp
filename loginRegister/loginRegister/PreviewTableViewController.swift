//
//  PreviewTableViewController.swift
//  loginRegister
//
//  Created by Angel Martinez on 3/24/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class PreviewTableViewController: UITableViewController {
    
    var users = [NSManagedObject]()
    var cart = [NSManagedObject]()
    
    var totalPrice:Float = 0
    var totalTime:Int = 0
    var completeOrder:String = ""
    
    @IBOutlet var previewTable: UITableView!
    
    @IBOutlet weak var previewTotal: UILabel!
    
    @IBAction func confirmOrderBtn(_ sender: Any)
    {
        // Delete the items in the cart (core data) so they do not persist in an additional order
        // Will segue to ConfirmationViewController, which has the item details
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        do{
            try persistentContainer.viewContext.execute(deleteRequest)
        }
        
        catch let error as NSError{
            print(error)
        }
        
        registerOrder(completeOrder:completeOrder)

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
        print("here")
        if let results = fetchedUser {
            users = results
            print("\(users.count)")
        } else {
            print("Could not fetch")
        }
        
        for elt in users {
            let testName = (elt.value(forKey: "loggedIn") as? Bool)!
            if testName {
                print("\(elt.value(forKey: "username")) is logged in")
            }
            print("\(testName)")
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
        loadData()
        for elt in cart{
            var testName = (elt.value(forKey: "title") as? String)!
            var testPrice = (elt.value(forKey: "price") as? Float)!
            var testTime = (elt.value(forKey: "time") as? Int)!
            print ("\(testPrice) \(testTime)")
            
            totalPrice += testPrice
            totalTime += testTime
            completeOrder += testName

            
        }

        previewTotal.text = String(totalPrice)
        print(totalTime)
        
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

        // Configure the cell...
        if(indexPath.row % 2 == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemPreviewTableViewCell", for:indexPath) as! ItemPreviewTableViewCell
            
            //print(cart[indexPath.section])
            
            cell.titlePreview.text = (cart[indexPath.section].value(forKey: "title") as? String)!
            //cell.itemPricePreview.text = "test"
            cell.itemPricePreview.text = String((cart[indexPath.section].value(forKey: "price") as? Float)!)
            
            return cell
        }
        
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"itemRemoveTableViewCell") as! ItemRemoveTableViewCell
            
            //cell.titlePreview.text = "Foo"
            //cell.itemPricePreview.text = cart[indexPath.section]
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ConfirmOrderSegue")
        {
            // Pass the items in the cart to the ConfirmationViewController to show
            // total time and dollar amount
            
            let viewController = segue.destination as! ConfirmationViewController
            viewController._orderTotal = totalPrice
            viewController._orderTime = totalTime
        }
    }
    

}
