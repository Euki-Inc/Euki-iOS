//
//  EUKAbortionViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/25/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKAbortionViewController: EUKCommonTopLevelViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Private
    
    override func createContent() {
        let contentItem = ContentItem()
        contentItem.title = "abortion"
        
        var items = [ContentItem]()
        items.append(ContentItem(id: "walk_me_through_the_process", imageIcon: "IconWalkThrough"))
        items.append(ContentItem(id: "knowledge_base", imageIcon: "IconKnowledgeBase"))
        contentItem.selectableItems = items
        
        self.contentItem = contentItem
    }
    
    override func showContentItem(item: ContentItem) {
        switch item.id {
        case "knowledge_base":
            ContentManager.sharedInstance.requestAbortionKnowledge { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        case "walk_me_through_the_process":
            ContentManager.sharedInstance.requestAbortionWalkthrough { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        default:
            print("Not supported option")
        }
    }
    
    //MARK: - Public
    
    class func initViewController() -> EUKAbortionViewController? {
        if let abortionViewController = super.initViewController(anyClass: EUKAbortionViewController.self) as? EUKAbortionViewController {
            return abortionViewController
        }
        return nil
    }

}
