//
//  ExpandableItem.swift
//  Euki
//
//  Created by Víctor Chávez on 3/30/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class ExpandableItem: NSObject {
    var id: String
    var title: String
    var text: String
    var isExpanded: Bool = false
    var contentItem: ContentItem
    
    init(id: String, title: String, text: String, contentItem: ContentItem) {
        self.id = id
        self.title = title
        self.text = text
        self.contentItem = contentItem
    }
}
