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
    
    func privacyBestPractices() -> ContentItem {
        let contentItem = ContentItem()
        contentItem.id = "privacy_best_practices"
        contentItem.title = "Privacy best practices_header"
        contentItem.content = "Privacy best practices_copy"
        contentItem.source = "Digital Defense Fund and If/When/How"
        contentItem.imageIcon = "iconPrivacyBestPractices"
        contentItem.expandableItems = [ContentItem]()
        
        let privateMessages = ContentItem()
        privateMessages.id = "protect_private_messages"
        privateMessages.title = "Protect your private messages_dropdown"
        privateMessages.content = "Protect your private messages_copy"
        
        contentItem.expandableItems!.append(privateMessages)
        
        let internetSearch = ContentItem()
        internetSearch.id = "protect_internet_search"
        internetSearch.title = "Protect your internet search history_dropdown"
        internetSearch.content = "Protect your internet search history_copy"
        internetSearch.links = [
            "el nivel gratuito de ProtonVPN":"https://account.protonvpn.com/signup/account",
            "el nivel gratuito limitado de Tunnelbear":"https://www.tunnelbear.com/pricing",
            
            "ProtonVPN’s free tier":"https://account.protonvpn.com/signup/account",
            "Tunnelbear’s limited free tier":"https://www.tunnelbear.com/pricing",
            
            "DuckDuckGo":"https://duckduckgo.com",
            "Firefox Focus":"https://apps.apple.com/us/app/apple-store/id1055677337?pt=373246&ct=firefox-browsers-mobile-focus&mt=8"]
        contentItem.expandableItems!.append(internetSearch)
        
        let paymentHistory = ContentItem()
        paymentHistory.id = "protect_payment_history"
        paymentHistory.title = "Protect your payment history_dropdown"
        paymentHistory.content = "Protect your payment history_copy"
        contentItem.expandableItems!.append(paymentHistory)
        
        let locationData = ContentItem()
        locationData.id = "protect_location_data"
        locationData.title = "Protect your location data and ad tracking_dropdown"
        locationData.content = "Protect your location data and ad tracking_copy"
        locationData.links = ["DuckDuckGo":"https://duckduckgo.com", "Firefox Focus":"https://apps.apple.com/us/app/apple-store/id1055677337?pt=373246&ct=firefox-browsers-mobile-focus&mt=8"]
        contentItem.expandableItems!.append(locationData)
        
        let resources = ContentItem()
        resources.id = "privacy_best_practices_resources"
        resources.title = "Resources_dropdown"
        resources.content = "Resources_copy"
        resources.links = ["Digital Defense Fund":"https://digitaldefensefund.org/ddf-guides/abortion-privacy", "If/When/How’s Repro Legal Helpline":"https://ifwhenhow.org", "Electronic Frontier Foundation privacy guidance":"https://www.eff.org/issues/privacy", "Repro Legal Helpline de If/When/How":"https://ifwhenhow.org", "Guía de privacidad de la Electronic Frontier Foundation": "https://www.eff.org/issues/privacy"]
        contentItem.expandableItems!.append(resources)
        
        return contentItem
    }
}
