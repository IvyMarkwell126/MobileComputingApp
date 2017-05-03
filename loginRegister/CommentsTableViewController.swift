//
//  CommentsTableViewController.swift
//  loginRegister
//
//  Created by ivy126 on 4/28/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class CommentsTableViewController: UITableViewController, UITextFieldDelegate {
    
    var data = [NSManagedObject]()
    var itemName:String?
    var comments = [NSManagedObject]()

    @IBOutlet weak var commentFld: UITextField!
    @IBOutlet var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentFld.delegate = self
        loadData(entName: "Comment")
        for elt in data {
            if (elt.value(forKey: "item") as? String)! == itemName {
                comments.append(elt)
            }
        }

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"CommentsTableViewCell", for:indexPath) as! CommentsTableViewCell
        print("here~~~~~~~~~~~~~~~~")
        var elt = comments[indexPath.row]
        cell.username.text = (elt.value(forKey: "user") as? String)!
        cell.comment.text = (elt.value(forKey: "remark") as? String)!
        return cell
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if commentFld.text != "" {
            loadData(entName: "User")
            for elt in data {
                let isLoggedIn = (elt.value(forKey: "loggedIn") as? Bool)!
                if isLoggedIn {
                    registerComment(passedUser: (elt.value(forKey: "username") as? String)!, passedItem: self.itemName!, passedRemark: self.commentFld.text!)
                    
                    //reloadTable() doesn't work so alert will force the user back to details
                    
                    var regisAlert = UIAlertController(title: "Thank You", message: "We appreciate your comment", preferredStyle: UIAlertControllerStyle.alert)
                    let OKAction = UIAlertAction(title: "Return to \(self.itemName!) Details", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                        _ = self.navigationController?.popViewController(animated: true)
                        self.commentFld.text = ""
                    }
                    regisAlert.addAction(OKAction)
                    present(regisAlert, animated: true, completion:nil)
                    
                    
                }
            }
        }
        else{
            var regisAlert = UIAlertController(title: "Error", message: "Cannot submit empty comment", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                //print("Ok Button Pressed 1");
            }
            regisAlert.addAction(OKAction)
            present(regisAlert, animated: true, completion:nil)
        }
    }
    
    func reloadTable(){
        self.tableView.reloadData()
        self.commentsTableView.reloadData()
    }
    
    func loadData(entName:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entName)
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
            data = results
        } else {
            print("Could not fetch")
        }
    }
    
    var users = [NSManagedObject]()
    
    func registerComment(passedUser:String, passedItem:String, passedRemark:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Comment", in: managedContext)
        let comment = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        comment.setValue(passedItem, forKey: "item")
        comment.setValue(passedUser, forKey: "user")
        comment.setValue(passedRemark, forKey: "remark")
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
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
        self.view.endEditing(true)
    }

}
