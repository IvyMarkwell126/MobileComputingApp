//
//  Appearance.swift
//  loginRegister
//
//  Created by Abel Morales on 4/14/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import Foundation
import UIKit

// UIAppearance is a protocol which UIKit components conform to that allows properties
// to be set at runtime for all instances of a class. For example, defining the background
// color that all UILabels (or custom classes derived from UILabel) will use.
//
// To use it, simply call the appearance() method of a UIView (which all UI element classes
// derive from) which conforms to the protocol. This gets you a proxy object which you can
// use to make style changes on and they will automagically be applied to all instances of
// that class in your app.

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

class Appearance {
    class func setInitialAppTheme() {
        UIButton.appearance().cornerRadius = 10;
        UIButton.appearance().backgroundColor = UIColor.init(red: 171/255.0, green: 250/255.0, blue: 242/255.0, alpha: 1.0)
        UIButton.appearance().titleLabelFont = UIFont(name: "Noteworthy", size: 17)
        //UILabel.appearance().defaultFont = UIFont(name: "Noteworthy", size: 17)
    }
}
