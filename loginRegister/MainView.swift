//
//  MainView.swift
//  loginRegister
//
//  Created by ivy126 on 5/3/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

class MainView: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picture.image = #imageLiteral(resourceName: "catchef.jpg")
        self.picture.layer.cornerRadius = picture.frame.height/2;
        self.picture.clipsToBounds = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
