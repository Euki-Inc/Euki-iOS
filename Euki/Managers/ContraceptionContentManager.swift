//
//  ContraceptionContentManager.swift
//  Euki
//
//  Created by Víctor Chávez on 1/19/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class ContraceptionContentManager: NSObject {
    static let sharedInstance = ContraceptionContentManager()
    
    let contentIds = ["iud", "copper_uid", "implant", "shot", "patch", "pill", "ring", "other_barriers", "condom", "pull_out", "tubes_tied", "rhythm"]
    
    func methodContentItem(index: Int) -> ContentItem? {
        let contentId = self.contentIds[index]
        return ContentManager.sharedInstance.requestContentItem(id: contentId)
    }
}
