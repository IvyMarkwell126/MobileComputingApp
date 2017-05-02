//
//  SettingsViewController.swift
//  loginRegister
//
//  Created by Angel Martinez on 4/12/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit
import CoreData

protocol ChangeColorDelegate {
    func changeColor(idx:Int)
}

class SettingsViewController: UIViewController {
    
    var btnDelegate:ChangeColorDelegate?
    var selectedIdx = 0
    
    @IBOutlet weak var veganSegCont: UISegmentedControl!
    @IBOutlet weak var gluteSegCont: UISegmentedControl!
    @IBOutlet weak var colorSegCont: UISegmentedControl!
    
    var isVegan:Bool = false
    var isGlute:Bool = false
    
    @IBOutlet weak var userLbl: UILabel!
    var users = [NSManagedObject]()
    var user:NSManagedObject?
    
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
        
        for elt in users {
            let isLoggedIn = (elt.value(forKey: "loggedIn") as? Bool)!
            if isLoggedIn {
                
                user = elt
                
            }
        }
    }

    override func viewDidLoad() {
        loginCheck()
        userLbl.text = (user?.value(forKey: "username") as? String)!
        let vegCheck = (user?.value(forKey: "vegan") as? Bool)!
        let gltCheck = (user?.value(forKey: "glutenFree") as? Bool)!
        if (vegCheck){
            veganSegCont.selectedSegmentIndex = 1
        }
        if (gltCheck){
            gluteSegCont.selectedSegmentIndex = 1
        }
 
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        user?.setValue(false, forKey: "loggedIn")
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }

    @IBAction func saveChangesBtn(_ sender: Any) {
        switch veganSegCont.selectedSegmentIndex {
        case 0:
            isVegan = false
        case 1:
            isVegan = true
        default:
            isVegan = false
        }
        switch gluteSegCont.selectedSegmentIndex {
        case 0:
            isGlute = false
        case 1:
            isGlute = true
        default:
            isGlute = false
        }
        print(isVegan, isGlute)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        user?.setValue(isVegan, forKey: "vegan")
        user?.setValue(isGlute, forKey: "glutenFree")
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        switch colorSegCont.selectedSegmentIndex {
        case 0:
            selectedIdx = 0
        case 1:
            selectedIdx = 1
        case 2:
            selectedIdx = 2
        case 3:
            selectedIdx = 3
        default:
            selectedIdx = 0
        }
        print(selectedIdx)
        if let delegate = btnDelegate{
            delegate.changeColor(idx: selectedIdx)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
