//
//  RemindersManager.swift
//  Euki
//
//  Created by Víctor Chávez on 6/5/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import UserNotifications

class RemindersManager: NSObject {
    static let sharedInstance = RemindersManager()
    
    func requestReminders(responseHandler: @escaping ([ReminderItem]) -> Void) {
        responseHandler(LocalDataManager.sharedInstance.reminders())
    }
    
    func saveReminders(reminders: [ReminderItem]) {
        LocalDataManager.sharedInstance.saveReminders(reminders: reminders)
    }
    
    func pendingNotify(responseHandler: @escaping (ReminderItem?) -> Void) {
        let reminders = LocalDataManager.sharedInstance.reminders()
        var toAlertReminder: ReminderItem?
        var toAlertDate: Date?
        for reminder in reminders {
            if let lastAlert = reminder.lastAlert, Calendar.current.isDateInToday(lastAlert) {
                continue
            }
            if let todayAlert = self.todayAlert(reminderItem: reminder) {
                if let toAlert = toAlertDate {
                    if toAlert < todayAlert {
                        toAlertReminder = reminder
                        toAlertDate = toAlert
                    }
                } else {
                    toAlertReminder = reminder
                    toAlertDate = todayAlert
                }
            }
        }
        toAlertReminder?.lastAlert = Date()
        self.saveReminders(reminders: reminders)
        responseHandler(toAlertReminder)
    }
    
    private func todayAlert(reminderItem: ReminderItem) -> Date? {
        let nowDate = Date()
        guard let startDate = reminderItem.date, let repeatDays = reminderItem.repeatDays, startDate < nowDate else {
            return nil
        }
        
        var currentDate = startDate
        
        while currentDate < nowDate {
            if Calendar.current.isDateInToday(currentDate) {
                return currentDate
            }
            
            if repeatDays == 0 {
                return nil
            }
            
            guard let date = Calendar.current.date(byAdding: .day, value: repeatDays, to: currentDate) else {
                return nil
            }
            currentDate = date
        }
        
        return nil
    }
}
