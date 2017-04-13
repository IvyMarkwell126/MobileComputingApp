//
//  MenuItem.swift
//  loginRegister
//
//  Created by Abel Morales on 3/23/17.
//  Copyright © 2017 Abel Morales. All rights reserved.
//

import UIKit

public class MenuItem: NSObject {
    public var title:String
    public var price:Float
    public var time:Int
    
    // Variables to be added for - vegan, gluten_free
    
    init(_title:String, _price:Float, _time: Int)
    {
        title = _title
        price = _price
        time = _time
    }

}
