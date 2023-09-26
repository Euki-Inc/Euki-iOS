//
//  EUKAutoContentViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/29/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKAutoContentViewController: EUKCommonContentViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Private
    
    override func createContent() {
        super.createContent()
        guard let contentItem = self.contentItem else {
            return
        }
        
        var expandableItems = [ExpandableItem]()
        
        if let contentItems = contentItem.expandableItems {
            for contentItem in contentItems {
                let exoandableItem = ExpandableItem(id: contentItem.id, title: contentItem.title?.localized ?? contentItem.id.localized, text: contentItem.content.localized, contentItem: contentItem)
                if let expandContentItem = self.expandContentItem, contentItem == expandContentItem {
                    exoandableItem.isExpanded = true
                }
                expandableItems.append(exoandableItem)
            }
        }
        
        self.items.removeAll()
        self.items.append(contentsOf: expandableItems)
    }
    
    //MARK: - Public
    
    class func initViewController() -> EUKAutoContentViewController? {
        if let viewController = super.initViewController(anyClass: EUKAutoContentViewController.self) as? EUKAutoContentViewController {
            return viewController
        }
        return nil
    }

}
