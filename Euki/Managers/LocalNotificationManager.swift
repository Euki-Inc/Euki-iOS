//
//  LocalNotificationManager.swift
//  Euki
//
//  Created by Víctor Chávez on 12/7/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import UserNotifications

class LocalNotificationManager: NSObject {
    static let sharedInstance = LocalNotificationManager()
    
    func createLocalNotification(date: Date, repeatDays: Int, responseHandler: @escaping (String?) -> Void) {
        self.verifyAuthorization(date: date, repeatDays: repeatDays, responseHandler: responseHandler)
    }
    
    private func verifyAuthorization(date: Date, repeatDays: Int, responseHandler: @escaping (String?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.createNotification(date: date, repeatDays: repeatDays, responseHandler: responseHandler)
            } else {
                DispatchQueue.main.async {
                    responseHandler(nil)
                }
            }
        }
    }
    
    private func createNotification(date: Date, repeatDays: Int, responseHandler: @escaping (String?) -> Void) {
        let uuidString = UUID().uuidString
        
        if repeatDays == 0 {
            let id = "\(uuidString)_0"
            self.createNotification(id: id, date: date) { (_) in
            }
        } else {
            for index in 0 ... 60 {
                let futureDate = Calendar.current.date(byAdding: .day, value: repeatDays * index, to: date)!
                let id = "\(uuidString)_\(index)"
                self.createNotification(id: id, date: futureDate) { (_) in
                }
            }
        }
        DispatchQueue.main.async {
            responseHandler(uuidString)
        }
    }
    
    func createNotification(id: String, date: Date, responseHandler: @escaping (String?) -> Void) {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let content = UNMutableNotificationContent()
        content.title = "Euki"
        content.body = "local_notification_message".localized
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                responseHandler(error == nil ? id : nil)
            }
        }
    }
    
    func deleteNotification(id: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            var notificationIds = [String]()
            for notification in notifications {
                if notification.identifier.contains(id) {
                    notificationIds.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: notificationIds)
        }
    }
    
    func deleteAllPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            let notificationIds = notifications.map({$0.identifier})
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: notificationIds)
        }
    }
}
