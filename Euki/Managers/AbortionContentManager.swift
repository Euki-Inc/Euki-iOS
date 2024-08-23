//
//  AbortionContentManager.swift
//  Euki
//
//  Created by Víctor Chávez on 12/5/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class AbortionContentManager: NSObject {
    static let sharedInstance = AbortionContentManager()
    
    let omsLinkDict = [
        "world_health_organization".localized: "https://apps.who.int/iris/bitstream/handle/10665/278968/9789241550406-eng.pdf?ua=1",
        "Miscarriage and Abortion Hotline": "https://www.mahotline.org/",
        "Repro Legal Hotline": "https://www.reprolegalhelpline.org/"
    ]
    
    func abortionMifeMiso12(withExpandables: Bool = true) -> ContentItem {
        let contentItem = ContentItem()
        contentItem.isAbortionItem = true
        contentItem.id = "mife_miso_12_weeks"
        
        var childItems = [ContentItem]()
        for index in 1 ... 7 {
            let childText = "mife_miso_12_text_\(index)"
            let childImage = "IconMifeMiso12_\(index)"
            
            let childItem = ContentItem(id: childText)
            childItem.links = omsLinkDict
            
            if index < 7 {
                childItem.imageIcon = childImage
            }
            childItems.append(childItem)
        }
        contentItem.contentItems = childItems
        if withExpandables{
            contentItem.expandableItems = self.abortionPillsExpandableItems(textFormat: "mife_miso_12_subheading_%d", contentFormat: "abortion_subheading_%d_content")
            contentItem.expandableItems?.forEach({$0.parent = contentItem})
        }
        
        return contentItem
    }
    
    func abortionMiso12(withExpandables: Bool = true) -> ContentItem {
        let contentItem = ContentItem()
        contentItem.isAbortionItem = true
        contentItem.id = "misoprostol_12_weeks"
        
        var childItems = [ContentItem]()
        for index in 1 ... 6 {
            let childText = "misoprostol_12_text_\(index)"
            let childImage = "IconMiso_\(index)"
            
            let childItem = ContentItem(id: childText)
            childItem.links = omsLinkDict
            
            if index < 6 {
                childItem.imageIcon = childImage
            }
            childItems.append(childItem)
        }
        contentItem.contentItems = childItems
        if withExpandables{
            contentItem.expandableItems = self.abortionPillsExpandableItems(textFormat: "misoprostol_12_subheading_%d", contentFormat: "abortion_subheading_%d_content")
            contentItem.expandableItems?.forEach({$0.parent = contentItem})
        }
        
        return contentItem
    }
    
    func abortionPillsExpandableItems(textFormat: String, contentFormat: String) -> [ContentItem] {
        var expandableItems = [ContentItem]()
        for index in 1 ... 5 {
            let childText = String(format: textFormat, index)
            let childContent = String(format: contentFormat, index)
            let childItem = ContentItem(id: childText)
            childItem.links = omsLinkDict
            childItem.isExpandableChild = true
            childItem.content = childContent
            expandableItems.append(childItem)
        }
        return expandableItems
    }
    
    func abortionSuctionVacuum(withExpandables: Bool = true) -> ContentItem {
        let contentItem = ContentItem()
        contentItem.isAbortionItem = true
        contentItem.id = "suction_or_vacuum"
        
        var childItems = [ContentItem]()
        for index in 1 ... 5 {
            let childText = "suction_or_vacuum_text_\(index-1)"
            let childImage = "IconVacuumAspiration\(index)"
            
            let childItem: ContentItem
            
            if index == 1 {
                childItem = ContentItem()
            } else {
                childItem = ContentItem(id: childText)
            }
            
            childItem.links = omsLinkDict
            if index < 5 {
                childItem.imageIcon = childImage
            }
            childItems.append(childItem)
        }
        contentItem.contentItems = childItems
        
        if withExpandables{
            contentItem.expandableItems = self.abortionSuctionExpandableItems(textFormat: "suction_or_vacuum_subheading_%d")
            contentItem.expandableItems?.forEach({$0.parent = contentItem})
        }
        
        return contentItem
    }
    
    func abortiondilationEvacuation(withExpandables: Bool = true) -> ContentItem {
        let contentItem = ContentItem()
        contentItem.isAbortionItem = true
        contentItem.id = "dilation_evacuation"
        
        var childItems = [ContentItem]()
        for index in 1 ... 5 {
            let childText = "dilation_evacuation_text_\(index-1)"
            let childImage = "IconAbortionDilation\(index)"
            
            let childItem: ContentItem
            
            if index == 1 {
                childItem = ContentItem()
            } else {
                childItem = ContentItem(id: childText)
            }
            
            childItem.links = omsLinkDict
            if index < 5 {
                childItem.imageIcon = childImage
            }
            childItems.append(childItem)
        }
        contentItem.contentItems = childItems
        
        if withExpandables{
            contentItem.expandableItems = self.abortionSuctionExpandableItems(textFormat: "dilation_evacuation_subheading_%d")
            contentItem.expandableItems?.forEach({$0.parent = contentItem})
        }
        
        return contentItem
    }
    
    func abortionSuctionExpandableItems(textFormat: String) -> [ContentItem] {
        var expandableItems = [ContentItem]()
        for index in 1 ... 2 {
            let childText = String(format: textFormat, index)
            let childContent = index == 1 ? "abortion_medical_aftercare" : "abortion_emotional_aftercare"
            let childItem = ContentItem(id: childText)
            childItem.links = omsLinkDict
            childItem.isExpandableChild = true
            childItem.content = childContent
            expandableItems.append(childItem)
        }
        return expandableItems
    }
    
}
