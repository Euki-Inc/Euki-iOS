//
//  MenstruationContentManager.swift
//  Euki
//
//  Created by Ahlem on 1/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation

class MenstruationContentManager : NSObject {
    static let sharedInstance = MenstruationContentManager()
    
    let contentIds = ["reusable_pad", "disposable_pad", "tampon", "menstrual_cup", "menstrual_disc", "period_underwear", "liner"]
    
    func methodContentItem(index: Int) -> ContentItem? {
        let contentId = self.contentIds[index]
        return ContentManager.sharedInstance.requestContentItem(id: contentId)
    }
    
}
