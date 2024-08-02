//
//  Bookmark.swift
//  Euki
//
//  Created by Víctor Chávez on 5/8/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class Bookmark: NSObject {
    var id: String
    var title: String
    var content: String
    var contentItem: ContentItem
    
    override init() {
        self.id = ""
        self.title = ""
        self.content = ""
        self.contentItem = ContentItem()
    }
    
    convenience init(id: String, title: String, content: String, contentItem: ContentItem) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
        self.contentItem = contentItem
    }
}
