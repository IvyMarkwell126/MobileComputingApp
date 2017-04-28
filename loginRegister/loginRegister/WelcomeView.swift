//
//  WelcomeView.swift
//  loginRegister
//
//  Created by Abel Morales on 3/22/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class WelcomeView: UIViewController {

    @IBOutlet var LoginAction: UIButton!
    @IBOutlet var RegisterAction: UIButton!

    var users = [NSManagedObject]()
    
    
    func loginCheck(){
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
            print("\(users.count)")
        } else {
            print("Could not fetch")
        }
        print(users.count)
        for elt in users {
            print(elt.value(forKey: "username")!)
            let isLoggedIn = (elt.value(forKey: "loggedIn") as? Bool)!
            if isLoggedIn {
                print("\(elt.value(forKey: "username")) is logged in")
                performSegue(withIdentifier: "welcome2main", sender: nil)
                break
            }
        }
    }
    
    func deleteAllUsers(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        do{
            try persistentContainer.viewContext.execute(deleteRequest)
        }
        catch let error as NSError{
            print(error)
        }
        
        print("Deteted All Users")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Uncomment this code and run to delete every user from the core data
        //deleteAllUsers()
        
        loginCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
