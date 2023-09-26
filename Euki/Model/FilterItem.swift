//
//  FilterItem.swift
//  Euki
//
//  Created by Víctor Chávez on 6/14/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class FilterItem: NSObject, NSCoding {
    var color: UIColor
    var title: String
    var isOn: Bool
    
    override init() {
        self.color = UIColor.white
        self.title = ""
        self.isOn = false
    }
    
    convenience init(color: UIColor, title: String, isOn: Bool) {
        self.init()
        self.color = color
        self.title = title
        self.isOn = isOn
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let color = UIColor.colorWithHexString(aDecoder.decodeObject(forKey: "color") as? String ?? "")
        let title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        let isOn = aDecoder.decodeBool(forKey: "isOn")
        self.init(color: color, title: title, isOn: isOn)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.color.hexString(false), forKey: "color")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.isOn, forKey: "isOn")
    }
}
