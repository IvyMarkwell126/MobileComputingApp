//
//  Appearance.swift
//  loginRegister
//
//  Created by Abel Morales on 4/14/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    dynamic var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    dynamic var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
}

extension UILabel{
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}

extension UIViewController{
    var backgroundColor:UIColor?{
        get { return self.backgroundColor }
        set { self.backgroundColor = newValue }
    }
}

class Appearance {
    
    static var redBtn:CGFloat = 170/255.0
    static var greBtn:CGFloat = 250/225.0
    static var bluBtn:CGFloat = 240/255.0
    static var redView:CGFloat = 10/255.0
    static var greView:CGFloat = 170/225.0
    static var bluView:CGFloat = 255/255.0
    
    class func setInitialAppTheme() {
        UIButton.appearance().cornerRadius = 10;
        UIButton.appearance().backgroundColor = UIColor.init(red: redBtn, green: greBtn, blue: bluBtn, alpha: 1.0)
        //UILabel.appearance().backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        
        //MyCustomView.appearance().backgroundColor = UIColor.init(red: redView, green: greView, blue: bluView, alpha: 1.0)
        //UITableView.appearance().backgroundColor = UIColor.init(red: redView, green: greView, blue: bluView, alpha: 1.0)
        //UITableViewCell.appearance().backgroundColor = UIColor.init(red: redView, green: greView, blue: bluView, alpha: 1.0)
        //ItemDetailsTableViewCell.appearance().backgroundColor = UIColor.init(red: redView, green: greView, blue: bluView, alpha: 1.0)
        
        UIButton.appearance().titleLabelFont = UIFont(name: "Noteworthy", size: 17)
        //UILabel.appearance().defaultFont = UIFont(name: "Noteworthy", size: 17)
    }
}
