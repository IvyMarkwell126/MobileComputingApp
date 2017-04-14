//
//  registerPageViewController.swift
//  loginRegister
//
//  Created by Abel Morales on 3/22/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

class registerPageViewController: UIViewController, UITextFieldDelegate {

    var user: NSManagedObject?
    var users = [NSManagedObject]()
    
    @IBOutlet var usrField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBOutlet var repassField: UITextField!
    @IBOutlet var messageLbl: UILabel!
    @IBOutlet var RegisterAction: UIButton!
    
    var regisAlert:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.RegisterAction.layer.cornerRadius = 10;
        
        usrField.delegate = self
        passField.delegate = self
        repassField.delegate = self

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
    
    @IBAction func saveBtn(_ sender: Any) {
        self.loadData()
        let userName = usrField.text!
        let passWord = passField.text!
        let rePassWord = repassField.text!
        var isTaken = false
        
        for elt in users{
            let testName = (elt.value(forKey: "username") as? String)!
            print(testName, userName)
            if(testName == userName){
                isTaken = true
                
                regisAlert = UIAlertController(title: "Error", message: "Username already taken", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                    //print("Ok Button Pressed 1");
                }
                regisAlert!.addAction(OKAction)
                present(self.regisAlert!, animated: true, completion:nil)
                break
            }
        }
        
        if(!isTaken){
        
            if (usrField.text == "" || passField.text == "" || repassField.text == "") {
                self.regisAlert = UIAlertController(title: "Error", message: "You must enter a value for all fields", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                //print("Ok Button Pressed 1");
                }
                self.regisAlert!.addAction(OKAction)
                self.present(self.regisAlert!, animated: true, completion:nil)
            }
            
            else if (passWord != rePassWord){
                self.regisAlert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                    //print("Ok Button Pressed 1");
                }
                self.regisAlert!.addAction(OKAction)
                self.present(self.regisAlert!, animated: true, completion:nil)
            }
            else{
            
                registerUser(passedLogin: userName, passedPassword: passWord, passedRePass: rePassWord)
            
                self.regisAlert = UIAlertController(title: "Success", message: "New User Registered", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                    self.performSegue(withIdentifier: "register2main", sender: nil)
                }
                self.regisAlert!.addAction(OKAction)
                self.present(self.regisAlert!, animated: true, completion:nil)
                
            
            }
        }
    }
    
    func registerUser(passedLogin:String, passedPassword:String, passedRePass:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let candidate = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        candidate.setValue(passedLogin, forKey: "username")
        candidate.setValue(passedPassword, forKey: "password")
        candidate.setValue(true, forKey: "loggedIn")
        
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
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
