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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginCheck()
        //self.LoginAction.layer.cornerRadius = 10;
        //self.RegisterAction.layer.cornerRadius = 10;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
