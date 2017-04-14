//
//  loginPageViewController.swift
//  loginRegister
//
//  Created by Abel Morales on 3/22/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class loginPageViewController: UIViewController, UITextFieldDelegate {

    var user: NSManagedObject?
    var users = [NSManagedObject]()
    var loginAlert:UIAlertController? = nil
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var LoginAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
        for elt in users {
            let isLoggedIn = (elt.value(forKey: "loggedIn") as? Bool)!
            if isLoggedIn {
                print("\(elt.value(forKey: "username")) is logged in")
                performSegue(withIdentifier: "login2main", sender: nil)
                break
            }
        }
        // Do any additional setup after loading the view.
        //self.LoginAction.layer.cornerRadius = 10;
        
        usernameField.delegate = self
        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
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
            users = results
        } else {
            print("Could not fetch")
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        let userName = usernameField.text
        let passWord = passwordField.text
        var loggedin = false
        for elt in users {
            let testName = (elt.value(forKey: "username") as? String)!
            let testPass = (elt.value(forKey: "password") as? String)!
            print ("\(testName) \(testPass)")
            if(userName == "" || passWord == ""){
                self.loginAlert = UIAlertController(title: "Error", message: "You cannot leave either field blank", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                    //print("Ok Button Pressed 1");
                }
                self.loginAlert!.addAction(OKAction)
                self.present(self.loginAlert!, animated: true, completion:nil)
                break
            }
            else if(userName == testName && passWord == testPass){
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                elt.setValue(true, forKey: "loggedIn")
                
                do {
                    try managedContext.save()
                } catch {
                    // what to do if an error occurs?
                    let nserror = error as NSError
                    print("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
                
                loggedin = true
                performSegue(withIdentifier: "login2main", sender: nil)
                break
            }
        }
        if(!loggedin){
            self.loginAlert = UIAlertController(title: "Error", message: "Username or password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                //print("Ok Button Pressed 1");
            }
            self.loginAlert!.addAction(OKAction)
            self.present(self.loginAlert!, animated: true, completion:nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
