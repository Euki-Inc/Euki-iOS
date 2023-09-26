//
//  PrivacyContentManager.swift
//  Euki
//
//  Created by Víctor Chávez on 1/19/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class PrivacyContentManager: NSObject {
    static let sharedInstance = PrivacyContentManager()
    
    func privacyFAQS() -> ContentItem {
        let fakePin = (LocalDataManager.sharedInstance.pinCode() ?? "") == "1111" ? "2222" : "1111"
        
        let contentItem = ContentItem()
        contentItem.id = "privacy_faq"
        
        var childItems = [ContentItem]()
        for index in 1 ... 4 {
            let childTitle = "privacy_faqs_title_\(index)"
            let childContent = "privacy_faqs_content_\(index)".localized.replacingOccurrences(of: "[FAKE_PIN]", with: fakePin)
            
            let childItem = ContentItem(id: childTitle)
            childItem.parent = contentItem
            childItem.isExpandableChild = true
            childItem.content = childContent
            childItems.append(childItem)
        }
        contentItem.expandableItems = childItems
        return contentItem
    }
    
    func privacyStatement() -> ContentItem {
        let contentItem = ContentItem()
        contentItem.id = "privacy_statement"
        contentItem.content = "privacy_statement_content"
        return contentItem
    }
}
