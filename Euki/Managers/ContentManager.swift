//
//  ContentManager.swift
//  Euki
//
//  Created by Víctor Chávez on 3/29/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContentManager: NSObject {
    static let sharedInstance = ContentManager()
    let AbortionKnowledgeJson = "abortion_knowledge"
    let AbortionWalkthroughJson = "abortion_walkthrough"
    let STIsJson = "stis"
    let ContraceptionJson = "contraception"
    let MiscarriageJson = "miscarriage"
    let SexRelationshipsJson = "sex_relationships"
    let PregnancyOptionsJson = "pregnancy_options"
    let menstruationOptionsJson = "menstruation_options"
    
    var abortionKnowledgeContentItem: ContentItem?
    var abortionWalkthroughContentItem: ContentItem?
    var STIsContentItem: ContentItem?
    var contraceptionContentItem: ContentItem?
    var miscarriageContentItem: ContentItem?
    var sexRelationshipsContentItem: ContentItem?
    var pregnancyOptionsContentItem: ContentItem?
    var menstruationContentItem: ContentItem?
    
    //MARK: - Public
    
    
    func requestMenstruationOptions(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.menstruationContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.menstruationContentItem = self.createContentItem(fileName: self.menstruationOptionsJson)
                DispatchQueue.main.async {
                    responseHandler(self.abortionKnowledgeContentItem)
                }
            }
        }
    }
    
    func requestAbortionKnowledge(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.abortionKnowledgeContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.abortionKnowledgeContentItem = self.createContentItem(fileName: self.AbortionKnowledgeJson)
                DispatchQueue.main.async {
                    responseHandler(self.abortionKnowledgeContentItem)
                }
            }
        }
    }
    
    func requestAbortionWalkthrough(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.abortionWalkthroughContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.abortionWalkthroughContentItem = self.createContentItem(fileName: self.AbortionWalkthroughJson)
                DispatchQueue.main.async {
                    responseHandler(self.abortionWalkthroughContentItem)
                }
            }
        }
    }
    
    func requestSTIs(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.STIsContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.STIsContentItem = self.createContentItem(fileName: self.STIsJson)
                DispatchQueue.main.async {
                    responseHandler(self.STIsContentItem)
                }
            }
        }
    }
    
    func requestContraception(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.contraceptionContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.contraceptionContentItem = self.createContentItem(fileName: self.ContraceptionJson)
                DispatchQueue.main.async {
                    responseHandler(self.contraceptionContentItem)
                }
            }
        }
    }
    
    func requestMiscarriage(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.miscarriageContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.miscarriageContentItem = self.createContentItem(fileName: self.MiscarriageJson)
                DispatchQueue.main.async {
                    responseHandler(self.miscarriageContentItem)
                }
            }
        }
    }
    
    func requestSexRelationships(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.sexRelationshipsContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.sexRelationshipsContentItem = self.createContentItem(fileName: self.SexRelationshipsJson)
                DispatchQueue.main.async {
                    responseHandler(self.sexRelationshipsContentItem)
                }
            }
        }
    }
    
    func requestPregnancyOptions(responseHandler: @escaping (ContentItem?) -> Void) {
        if let contentItem = self.pregnancyOptionsContentItem {
            responseHandler(contentItem)
        } else{
            DispatchQueue.global(qos: .background).async {
                self.pregnancyOptionsContentItem = self.createContentItem(fileName: self.PregnancyOptionsJson)
                DispatchQueue.main.async {
                    responseHandler(self.pregnancyOptionsContentItem)
                }
            }
        }
    }
    
    func requestContentItem(id: String, responseHandler: @escaping (ContentItem?) -> Void) {
        self.requestAbortionKnowledge { [unowned self] (abortionContentItem) in
            if let abortionContentItem = abortionContentItem {
                if let contentItem = self.searchContentItem(id: id, contentItem: abortionContentItem) {
                    responseHandler(contentItem)
                    return
                }
            }
            
            responseHandler(nil)
        }
    }
    
    func requestContentItem(id: String) -> ContentItem? {
     
        if self.menstruationContentItem == nil {
               self.menstruationContentItem = self.createContentItem(fileName: self.menstruationOptionsJson)
           }
        
        
        if self.abortionKnowledgeContentItem == nil {
            self.abortionKnowledgeContentItem = self.createContentItem(fileName: self.AbortionKnowledgeJson)
        }
        
        if let abortionKnowledgeContentItem = self.abortionKnowledgeContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: abortionKnowledgeContentItem) {
                return contentItem
            }
        }
        
        if self.abortionWalkthroughContentItem == nil {
            self.abortionWalkthroughContentItem = self.createContentItem(fileName: self.AbortionWalkthroughJson)
        }
        
        if let abortionWalkthroughContentItem = self.abortionWalkthroughContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: abortionWalkthroughContentItem) {
                return contentItem
            }
        }
        
        if self.STIsContentItem == nil {
            self.STIsContentItem = self.createContentItem(fileName: self.STIsJson)
        }
        
        if let STIsContentItem = self.STIsContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: STIsContentItem) {
                return contentItem
            }
        }
        
        if self.contraceptionContentItem == nil {
            self.contraceptionContentItem = self.createContentItem(fileName: self.ContraceptionJson)
        }
        
        if let contraceptionContentItem = self.contraceptionContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: contraceptionContentItem) {
                return contentItem
            }
        }
        
        if self.miscarriageContentItem == nil {
            self.miscarriageContentItem = self.createContentItem(fileName: self.MiscarriageJson)
        }
        
        if let miscarriageContentItem = self.miscarriageContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: miscarriageContentItem) {
                return contentItem
            }
        }
        
        if self.sexRelationshipsContentItem == nil {
            self.sexRelationshipsContentItem = self.createContentItem(fileName: self.SexRelationshipsJson)
        }
        
        if let sexRelationshipsContentItem = self.sexRelationshipsContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: sexRelationshipsContentItem) {
                return contentItem
            }
        }
        
        if self.pregnancyOptionsContentItem == nil {
            self.pregnancyOptionsContentItem = self.createContentItem(fileName: self.PregnancyOptionsJson)
        }
        
        if let pregnancyOptionsContentItem = self.pregnancyOptionsContentItem {
            if let contentItem = self.searchContentItem(id: id, contentItem: pregnancyOptionsContentItem) {
                return contentItem
            }
        }
        
        // Abortion ContentItems
        
        if let contentItem = self.searchContentItem(id: id, contentItem: AbortionContentManager.sharedInstance.abortionMifeMiso12()) {
            return contentItem
        }
        if let contentItem = self.searchContentItem(id: id, contentItem: AbortionContentManager.sharedInstance.abortionMiso12()) {
            return contentItem
        }
        if let contentItem = self.searchContentItem(id: id, contentItem: AbortionContentManager.sharedInstance.abortionSuctionVacuum()) {
            return contentItem
        }
        if let contentItem = self.searchContentItem(id: id, contentItem: AbortionContentManager.sharedInstance.abortiondilationEvacuation()) {
            return contentItem
        }
        
        switch id {
        case "MedicalAbortion":
            return EUKMedicalAbortionViewController.contentItem()
        default:
            break
        }
        
        if let contentItem = self.searchContentItem(id: id, contentItem: PrivacyContentManager.sharedInstance.privacyFAQS()) {
            return contentItem
        }
		
		if let contentItem = self.searchContentItem(id: id, contentItem: PrivacyContentManager.sharedInstance.privacyStatement()) {
			return contentItem
		}
        
        return nil
    }
    
    func searchContentItem(id: String, contentItem: ContentItem) -> ContentItem? {
        if contentItem.id == id {
            return contentItem
        }
        
        if let contentItems = contentItem.contentItems {
            for childItem in contentItems {
                if let contentItem = self.searchContentItem(id: id, contentItem: childItem) {
                    return contentItem
                }
            }
        }
        
        if let expandableItems = contentItem.expandableItems {
            for childItem in expandableItems {
                if let contentItem = self.searchContentItem(id: id, contentItem: childItem) {
                    return contentItem
                }
            }
        }
        
        if let selectableItems = contentItem.selectableItems {
            for childItem in selectableItems {
                if let contentItem = self.searchContentItem(id: id, contentItem: childItem) {
                    return contentItem
                }
            }
        }
        
        if let selectableItems = contentItem.selectableRowItems {
            for childItem in selectableItems {
                if let contentItem = self.searchContentItem(id: id, contentItem: childItem) {
                    return contentItem
                }
            }
        }
        
        return nil
    }
    
    //MARK: - Global Search
    func requestContentItem(searchText: String) -> [ContentItem] {
        var contentItems = [ContentItem]()
        
        if self.menstruationContentItem == nil {
            self.menstruationContentItem = self.createContentItem(fileName: self.menstruationOptionsJson)
        }
        
        if let menstruationContentItem = self.menstruationContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: menstruationContentItem))
        }
        
        if self.abortionKnowledgeContentItem == nil {
            self.abortionKnowledgeContentItem = self.createContentItem(fileName: self.AbortionKnowledgeJson)
        }
        
        if let abortionKnowledgeContentItem = self.abortionKnowledgeContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: abortionKnowledgeContentItem))
        }
        
        if self.abortionWalkthroughContentItem == nil {
            self.abortionWalkthroughContentItem = self.createContentItem(fileName: self.AbortionWalkthroughJson)
        }
        
        if let abortionWalkthroughContentItem = self.abortionWalkthroughContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: abortionWalkthroughContentItem))
        }
        
        if self.STIsContentItem == nil {
            self.STIsContentItem = self.createContentItem(fileName: self.STIsJson)
        }
        
        if let STIsContentItem = self.STIsContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: STIsContentItem))
        }
        
        if self.contraceptionContentItem == nil {
            self.contraceptionContentItem = self.createContentItem(fileName: self.ContraceptionJson)
        }
        
        if let contraceptionContentItem = self.contraceptionContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: contraceptionContentItem))
        }
        
        if self.miscarriageContentItem == nil {
            self.miscarriageContentItem = self.createContentItem(fileName: self.MiscarriageJson)
        }
        
        if let miscarriageContentItem = self.miscarriageContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: miscarriageContentItem))
        }
        
        if self.sexRelationshipsContentItem == nil {
            self.sexRelationshipsContentItem = self.createContentItem(fileName: self.SexRelationshipsJson)
        }
        
        if let sexRelationshipsContentItem = self.sexRelationshipsContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: sexRelationshipsContentItem))
        }
        
        if self.pregnancyOptionsContentItem == nil {
            self.pregnancyOptionsContentItem = self.createContentItem(fileName: self.PregnancyOptionsJson)
        }
        
        if let pregnancyOptionsContentItem = self.pregnancyOptionsContentItem {
            contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: pregnancyOptionsContentItem))
        }
        
        // Abortion ContentItems
        
        contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: AbortionContentManager.sharedInstance.abortionMifeMiso12()))
        contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: AbortionContentManager.sharedInstance.abortionMiso12()))
        contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: AbortionContentManager.sharedInstance.abortionSuctionVacuum()))
        contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: AbortionContentManager.sharedInstance.abortiondilationEvacuation()))
        contentItems.append(contentsOf: self.searchContentItem(searchText: searchText, contentItem: EUKMedicalAbortionViewController.contentItem()))
        
        var uniqueContentItems = [ContentItem]()
        
        for contentItem in contentItems {
            if !uniqueContentItems.contains(contentItem) {
                uniqueContentItems.append(contentItem)
            }
        }
        
        return uniqueContentItems
    }
    
    func searchContentItem(searchText: String, contentItem: ContentItem) -> [ContentItem] {
        var contentItems = [ContentItem]()
        
        if contentItem.id.localized.lowercased().contains(searchText.lowercased()) {
            contentItems.append(contentItem)
        }
        if let title = contentItem.title?.localized.lowercased(), title.contains(searchText.lowercased()) {
            contentItems.append(contentItem)
        }
        if contentItem.content.localized.lowercased().contains(searchText.lowercased()) {
            contentItems.append(contentItem)
        }
        
        if let items = contentItem.contentItems {
            for childItem in items {
                if self.searchContentItem(searchText: searchText, contentItem: childItem).count > 0 {
                    contentItems.append(contentItem)
                }
            }
        }
        
        if let expandableItems = contentItem.expandableItems {
            for childItem in expandableItems {
                if self.searchContentItem(searchText: searchText, contentItem: childItem).count > 0 {
                    contentItems.append(contentItem)
                }
            }
        }
        
        if let selectableItems = contentItem.selectableItems {
            for childItem in selectableItems {
                let foundItems = self.searchContentItem(searchText: searchText, contentItem: childItem)
                contentItems.append(contentsOf: foundItems)
            }
        }
        
        if let selectableItems = contentItem.selectableRowItems {
            for childItem in selectableItems {
                let foundItems = self.searchContentItem(searchText: searchText, contentItem: childItem)
                contentItems.append(contentsOf: foundItems)
            }
        }
        
        return contentItems
    }
    
    //MARK: - Private
    
    fileprivate func createContentItem(fileName: String) -> ContentItem? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                print("jsonData:\(jsonObj)")
                return ContentItem(json: jsonObj)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
}
