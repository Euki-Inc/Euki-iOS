//
//  PrivacyManager.swift
//  Euki
//
//  Created by Víctor Chávez on 12/12/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class PrivacyManager: NSObject {
    static let sharedInstance = PrivacyManager()

    func removeAllData() {
        LocalNotificationManager.sharedInstance.deleteAllPendingNotifications()
        LocalDataManager.sharedInstance.removeAll()
        CalendarManager.sharedInstance.removeAll()
        BookmarksManager.sharedInstance.removeAllBookmarks()
    }
    
    func verifyAutoRemoveData() {
        guard let type = LocalDataManager.sharedInstance.recurringDataRemoval(), let lastAutoDeleteDate = LocalDataManager.sharedInstance.lastAutoDelete() else {
            return
        }
        
        let daysDiff = lastAutoDeleteDate.daysDiff(date: Date())
        let autoRemoveDaysMax: Int
        
        switch type {
        case .weekly:
            autoRemoveDaysMax = 7
        case .weekly2:
            autoRemoveDaysMax = 14
        case .monthly:
            autoRemoveDaysMax = 30
        case .monthly3:
            autoRemoveDaysMax = 90
        case .yearly:
            autoRemoveDaysMax = 365
        }
        
        if daysDiff >= autoRemoveDaysMax {
            self.removeAllData()
            LocalDataManager.sharedInstance.saveLastAutoDelete(date: Date())
        }
    }
    
    func saveRecurrentData(type: LocalDataManager.RecurringType?) {
        LocalDataManager.sharedInstance.saveRecurringDataRemoval(type: type)
        LocalDataManager.sharedInstance.saveLastAutoDelete(date: type == nil ? nil : Date())
    }
}
