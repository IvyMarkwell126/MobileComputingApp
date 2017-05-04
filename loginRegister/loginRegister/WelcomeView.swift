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

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet var LoginAction: UIButton!
    @IBOutlet var RegisterAction: UIButton!

    var users = [NSManagedObject]()
    
    //Function that iterates through all users in core data to check who is logged in
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
        } else {
            print("Could not fetch")
        }
        
        //If a user is logged in, segue straight to the main menu
        for elt in users {
            let isLoggedIn = (elt.value(forKey: "loggedIn") as? Bool)!
            if isLoggedIn {
                performSegue(withIdentifier: "welcome2main", sender: nil)
                break
            }
        }
    }
    
    func deleteCoreData(entName:String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        do{
            try persistentContainer.viewContext.execute(deleteRequest)
        }
        catch let error as NSError{
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picture.image = #imageLiteral(resourceName: "catchef.jpg")
        self.picture.layer.cornerRadius = picture.frame.height/2;
        self.picture.clipsToBounds = true;
        //Uncomment this code and run to delete every user or comment from the core data
        //deleteCoreData(entName: "User")
        //deleteCoreData(entName: "Comment")
        
        loginCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
