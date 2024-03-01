//
//  HomeManager.swift
//  Euki
//
//  Created by Víctor Chávez on 10/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class HomeManager: NSObject {
    static let sharedInstance = HomeManager()
    var items = [ContentItem]()
    
    func requestMainItems() -> [ContentItem] {
        var items = [ContentItem]()
        items.append(ContentItem(id: "menstruation", imageIcon: "IconMenstruation"))
        items.append(ContentItem(id: "abortion", imageIcon: "IconAbortion"))
        items.append(ContentItem(id: "contraception", imageIcon: "IconContraception"))
        items.append(ContentItem(id: "sexuality", imageIcon: "IconSexuality"))
        items.append(ContentItem(id: "miscarriage", imageIcon: "IconMiscarriage"))
        items.append(ContentItem(id: "pregnancy_options", imageIcon: "IconPregnancyOptions"))
        items.append(ContentItem(id: "stis", imageIcon: "IconSTIs"))
        
        for item in items {
            item.title = LocalDataManager.sharedInstance.string(key: item.id)
        }
        
        self.items = items
        return items
    }
    
    func saveTitle(item: ContentItem, title: String?) {
        LocalDataManager.sharedInstance.saveString(key: item.id, value: title)
    }
    
    func saveHomeOrder(usedItems: [ContentItem], notUsedItems: [ContentItem]) {
        LocalDataManager.sharedInstance.saveUsedItemsIds(ids: usedItems.map({ $0.id }))
        LocalDataManager.sharedInstance.saveNotUsedItemsIds(ids: notUsedItems.map({ $0.id }))
    }
    
    func homeOrder() -> ([ContentItem], [ContentItem]) {
        var usedItems = [ContentItem]()
        var notUsedItems = [ContentItem]()
        
        if let idsArray = LocalDataManager.sharedInstance.usedItemsIds() {
            for id in idsArray {
                if let index = self.items.lastIndex(where: {$0.id == id}) {
                    let usedItem = self.items[index]
                    usedItems.append(usedItem)
                }
            }
        } else {
            usedItems.append(contentsOf: self.items)
        }
        
        if let idsArray = LocalDataManager.sharedInstance.notUsedItemsIds() {
            for id in idsArray {
                if let index = self.items.lastIndex(where: {$0.id == id}) {
                    let notUsedItem = self.items[index]
                    notUsedItems.append(notUsedItem)
                }
            }
        }
        
        return (usedItems, notUsedItems)
    }
}
