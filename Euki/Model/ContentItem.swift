//
//  ContentItem.swift
//  Euki
//
//  Created by Víctor Chávez on 3/20/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContentItem: NSObject {
    var id: String
    var title: String?
    var shortTitle: String?
    var imageIcon: String
    var content: String
    var isExpandableChild = false
    var parent: ContentItem?
    var contentItems: [ContentItem]?
    var expandableItems: [ContentItem]?
    var selectableItems: [ContentItem]?
    var swipePagerItems: [SwipePagerItem]?
    var selectableRowItems: [ContentItem]?
    var source: String?
    var links: [String: String]?
    var uniqueLinks: [String: String]?
    var boldStrings: [String]?
    var isAbortionItem = false
    
    override init() {
        self.id = ""
        self.imageIcon = ""
        self.content = ""
    }
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
    
    convenience init(id: String, imageIcon: String) {
        self.init()
        self.id = id
        self.imageIcon = imageIcon
    }
    
    convenience init(id: String, imageIcon: String, content: String) {
        self.init()
        self.id = id
        self.imageIcon = imageIcon
        self.content = content
    }
    
    convenience init(id: String, title: String, content: String) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
    }
    
    convenience init(id: String, imageIcon: String, title: String?) {
        self.init()
        self.id = id
        self.imageIcon = imageIcon
        self.title = title
    }
    
    convenience init(json: JSON) {
        self.init()
        
        if let id = json["id"].string {
            self.id = id
        }
        if let title = json["title"].string {
            self.title = title
        }
        if let shortTitle = json["short_title"].string {
            self.shortTitle = shortTitle
        }
        if let icon = json["icon"].string {
            self.imageIcon = icon
        }
        if let content = json["content"].string {
            self.content = content
        }
        if let source = json["source"].string {
            self.source = source
        }
        if let contentItemsJsonArray = json["content_items"].array {
            var items = [ContentItem]()
            for contentItemJson in contentItemsJsonArray {
                let childItem = ContentItem(json: contentItemJson)
                childItem.parent = self
                items.append(childItem)
            }
            if items.count > 0 {
                self.contentItems = items
            }
        }
        if let expandableItemsJsonArray = json["expandable_items"].array {
            var items = [ContentItem]()
            for contentItemJson in expandableItemsJsonArray {
                let childItem = ContentItem(json: contentItemJson)
                childItem.parent = self
                childItem.isExpandableChild = true
                items.append(childItem)
            }
            if items.count > 0 {
                self.expandableItems = items
            }
        }
        if let selectableItemsJsonArray = json["selectable_items"].array {
            var items = [ContentItem]()
            for contentItemJson in selectableItemsJsonArray {
                let childItem = ContentItem(json: contentItemJson)
                childItem.parent = self
                items.append(childItem)
            }
            if items.count > 0 {
                self.selectableItems = items
            }
        }
        if let selectableItemsJsonArray = json["selectable_row_items"].array {
            var items = [ContentItem]()
            for contentItemJson in selectableItemsJsonArray {
                let childItem = ContentItem(json: contentItemJson)
                childItem.parent = self
                items.append(childItem)
            }
            if items.count > 0 {
                self.selectableRowItems = items
            }
        }
        if json["links"].exists() {
            var links = [String: String]()
            for (key, subJson) in json["links"] {
                if let value = subJson.string {
                    links[key] = value
                }
            }
            self.links = links
        }
        if json["unique_links"].exists() {
            var links = [String: String]()
            for (key, subJson) in json["unique_links"] {
                if let value = subJson.string {
                    links[key] = value
                }
            }
            self.uniqueLinks = links
        }
        if let boldStringsArray = json["bold_strings"].array {
            var boldStrings = [String]()
            for item in boldStringsArray {
                if let string = item.string {
                    boldStrings.append(string)
                }
            }
            self.boldStrings = boldStrings.isEmpty ? nil : boldStrings
        }
        
        if let swipePagerItemsJsonArray = json["swipe_pager_item"].array {
                  var items = [SwipePagerItem]()
                  for swipePagerItemJson in swipePagerItemsJsonArray {
                      let pagerItem = SwipePagerItem(json: swipePagerItemJson)
                      items.append(pagerItem)
                  }
                  if items.count > 0 {
                      self.swipePagerItems = items
                  }
              }
    }
    
    func isDeeperLevel() -> Bool {
        return (self.selectableItems?.count ?? 0) == 0
    }
}
