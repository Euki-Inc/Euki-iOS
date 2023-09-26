//
//  SelectItem.swift
//  Euki
//
//  Created by Víctor Chávez on 10/20/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class SelectItem: NSObject {
    var imageName: String
    var title: String
    var count: Int
    
    override init() {
        self.imageName = ""
        self.title = ""
        self.count = 0
    }
    
    convenience init(imageName: String, title: String) {
        self.init()
        self.imageName = imageName
        self.title = title
    }
}
