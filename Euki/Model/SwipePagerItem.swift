//
//  SwipePagerItem.swift
//  Euki
//
//  Created by Ahlem on 11/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwipePagerItem : NSObject {
    var id: String
       var content: String
       var icon: String

       init(id: String, content: String, icon: String) {
           self.id = id
           self.content = content
           self.icon = icon
       }

       convenience init(json: JSON) {
           self.init(
               id: json["id"].stringValue,
               content: json["content"].stringValue,
               icon: json["icon"].stringValue
           )
       }
}
