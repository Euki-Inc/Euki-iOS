//
//  LocalDataManager.swift
//  Euki
//
//  Created by Víctor Chávez on 4/30/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import SwiftyJSON

class LocalDataManager: NSObject {
    static let sharedInstance = LocalDataManager()
    
    enum RecurringType: Int {
        case weekly = 1,
        weekly2, monthly, monthly3, yearly
    }
    
    private let ShowOnboardingScreensKey = "ShowOnboardingScreensKey"
    private let PinCodeKey = "PinCodeKey"
    private let BookmarksKey = "BookmarksKey"
    private let RemindersKey = "RemindesKey"
    private let HomeItemsUsedKey = "HomeItemsUsedKey"
    private let HomeNotItemsUsedKey = "HomeNotItemsUsedKey"
    private let RecurringDataRemovalKey = "RecurringDataRemovalKey"
    private let LastDateAutoDeleteKey = "LastDateAutoDeleteKey"
    private let TabBarTutorialKey = "TabBarTutorialKey"
    private let DailyLogTutorialKey = "DailyLogTutorialKey"
	private let TrackBleedingTutorialKey = "TrackBleedingTutorialKey"
    private let CalendarTutorialKey = "CalendarTutorialKey"
	private let CycleSummaryTutorialKey = "CycleSummaryTutorialKey"
    private let DailyLogCounterKey = "DailyLogCounterKey"
    private let VersionKey = "VersionKey"
    private let ShouldShowPinUpdateKey = "ShouldShowPinUpdateKey"
	private let LatestBleedingTrackingKey = "LatestBleedingTrackingKey"
	private let UsedFilterItemsKey = "UsedFilterItemsKey"
	private let NotUsedFilterItemsKey = "NotUsedFilterItemsKey"
	private let HiddenCyclePeriodsKey = "HiddenCyclePeriodsKey"
	private let TrackPeriodEnabledKey = "TrackPeriodEnabledKey"
	private let PeriodPredictionEnabledKey = "PeriodPredictionEnabledKey"
    
    private var userDefaults = EUkiUserDefaults.sharedInstance
    
    func saveOnboardingScreens(show: Bool) {
        self.userDefaults.set(show, forKey: ShowOnboardingScreensKey)
        self.userDefaults.synchronize()
    }
    
    func showOnboardingScreens() -> Bool {
        if let showOnboarding = self.userDefaults.object(forKey: ShowOnboardingScreensKey) as? Bool {
            return showOnboarding
        }
        
        return true
    }
    
    func saveString(key: String, value: String?) {
        self.userDefaults.set(value, forKey: key)
        self.userDefaults.synchronize()
    }
    
    func string(key: String) -> String? {
        return self.userDefaults.string(forKey: key)
    }
    
    func savePincode(pinCode: String?) {
        self.userDefaults.set(pinCode, forKey: PinCodeKey)
        self.userDefaults.synchronize()
    }
    
    func pinCode() -> String? {
        return self.userDefaults.string(forKey: PinCodeKey)
    }
    
    func saveBookmarks(bookmarks: [String]) {
        self.userDefaults.set(bookmarks, forKey: BookmarksKey)
        self.userDefaults.synchronize()
    }
    
    func bookmarks() -> [String] {
        var bookmarksArray = [String]()
        if let array = self.userDefaults.array(forKey: BookmarksKey) {
            for bookmarkObject in array {
                if let bookmark = bookmarkObject as? String {
                    bookmarksArray.append(bookmark)
                }
            }
        }
        return bookmarksArray
    }
    
    func removeBookmarks() {
        self.userDefaults.set(nil, forKey: BookmarksKey)
        self.userDefaults.synchronize()
    }
    
    func saveReminders(reminders: [ReminderItem]) {
        var remindersDicts = [Any]()
        
        for reminder in reminders {
            var reminderDict = [
                "title": reminder.title!,
                "text": reminder.text!,
				"date": Int(reminder.date!.timeIntervalSince1970),
                "repeatDays": reminder.repeatDays as Any]
            
            if let id = reminder.id {
                reminderDict["id"] = id
            }
            if let lastAlert = reminder.lastAlert {
				reminderDict["lastAlert"] = Int(lastAlert.timeIntervalSince1970)
            }
            remindersDicts.append(reminderDict)
        }
        
        self.userDefaults.set(remindersDicts, forKey: RemindersKey)
        self.userDefaults.synchronize()
    }
    
    func reminders() -> [ReminderItem] {
        var remindersArray = [ReminderItem]()
        
        if let array = self.userDefaults.array(forKey: RemindersKey) {
            for reminderObject in array {
                if let reminderDict = reminderObject as? [String: Any] {
                    let reminderItem = ReminderItem()

                    if let id = reminderDict["id"] as? String, !id.isEmpty {
                        reminderItem.id = id
                    }
                    if let title = reminderDict["title"] as? String {
                        reminderItem.title = title
                    }
                    if let text = reminderDict["text"] as? String {
                        reminderItem.text = text
                    }
                    if let dateInt = reminderDict["date"] as? Int {
                        reminderItem.date = Date(timeIntervalSince1970: TimeInterval(dateInt))
                    }
                    if let repeatDays = reminderDict["repeatDays"] as? Int {
                        reminderItem.repeatDays = repeatDays
                    }
                    if let lastAlertInt = reminderDict["lastAlert"] as? Int {
                        reminderItem.lastAlert = Date(timeIntervalSince1970: TimeInterval(lastAlertInt))
                    }
                    remindersArray.append(reminderItem)
                }
            }
        }
        
        return remindersArray
    }
    
    func saveUsedItemsIds(ids: [String]) {
        self.userDefaults.set(ids, forKey: HomeItemsUsedKey)
        self.userDefaults.synchronize()
    }
    
    func usedItemsIds() -> [String]? {
        return self.userDefaults.object(forKey: HomeItemsUsedKey) as? [String]
    }
    
    func saveNotUsedItemsIds(ids: [String]) {
        self.userDefaults.set(ids, forKey: HomeNotItemsUsedKey)
        self.userDefaults.synchronize()
    }
    
    func notUsedItemsIds() -> [String]? {
        return self.userDefaults.object(forKey: HomeNotItemsUsedKey) as? [String]
    }
    
    func saveRecurringDataRemoval(type: RecurringType?) {
        self.userDefaults.set(type?.rawValue ?? nil, forKey: self.RecurringDataRemovalKey)
        self.userDefaults.synchronize()
    }
    
    func recurringDataRemoval() -> RecurringType? {
        if let typeInt = self.userDefaults.object(forKey: self.RecurringDataRemovalKey) as? Int, let type = RecurringType(rawValue: typeInt) {
            return type
        }
        
        return nil
    }
    
    func saveLastAutoDelete(date: Date?) {
        var saveDate: Date? = nil
        
        if let date = date {
            saveDate = Calendar.current.startOfDay(for: date)
        }
        
        self.userDefaults.set(saveDate, forKey: self.LastDateAutoDeleteKey)
        self.userDefaults.synchronize()
    }
    
    func lastAutoDelete() -> Date? {
        if let date = self.userDefaults.object(forKey: self.LastDateAutoDeleteKey) as? Date {
            return date
        }
        
        return nil
    }
    
    func shouldShowTabbarTutorial() -> Bool {
        if let showTabbarTutorial = self.userDefaults.object(forKey: self.TabBarTutorialKey) as? Bool {
            return showTabbarTutorial
        }
        
        self.userDefaults.set(false, forKey: self.TabBarTutorialKey)
        self.userDefaults.synchronize()
        return true
    }
    
    func shouldShowDailyLogTutorial() -> Bool {
        if let dailyLogTutorial = self.userDefaults.object(forKey: self.DailyLogTutorialKey) as? Bool {
            return dailyLogTutorial
        }
        
        self.userDefaults.set(false, forKey: self.DailyLogTutorialKey)
        self.userDefaults.synchronize()
        return true
    }
	
	func shouldShowTrackBleedingTutorial() -> Bool {
        if let trackBleedingTutorial = self.userDefaults.object(forKey: self.TrackBleedingTutorialKey) as? Bool {
            return trackBleedingTutorial
        }

        self.userDefaults.set(false, forKey: self.TrackBleedingTutorialKey)
        self.userDefaults.synchronize()
		return true
	}
    
    func shouldShowCalendarTutorial() -> Bool {
        let showCalendarTutorial = self.userDefaults.bool(forKey: self.CalendarTutorialKey)
        
        if showCalendarTutorial {
            self.userDefaults.set(false, forKey: self.CalendarTutorialKey)
            self.userDefaults.synchronize()
        }
        
        return showCalendarTutorial
    }
	
	func shouldShowCycleSummaryTutorial() -> Bool {
		let showCycleSummaryTutorial = self.userDefaults.bool(forKey: self.CycleSummaryTutorialKey, defaultValue: true)
		
		if showCycleSummaryTutorial {
			self.userDefaults.set(false, forKey: self.CycleSummaryTutorialKey)
			self.userDefaults.synchronize()
		}
		
		return showCycleSummaryTutorial
	}
    
    func addDailyLogCounter() {
        var currentCounter = self.userDefaults.integer(forKey: self.DailyLogCounterKey)
        currentCounter += 1
        self.userDefaults.set(currentCounter, forKey: self.DailyLogCounterKey)
        
        if currentCounter == 3 {
            self.userDefaults.set(true, forKey: self.CalendarTutorialKey)
        }
        
        self.userDefaults.synchronize()
    }
    
    func shouldShowPinUpdate() -> Bool {
        let shouldShowPin = self.userDefaults.bool(forKey: self.ShouldShowPinUpdateKey, defaultValue: true)
        if !shouldShowPin {
            return false
        }
        
        return self.pinCode() != nil
    }
    
    func saveShouldShowPinUpdate(value: Bool) {
        let shouldShowPin = self.userDefaults.bool(forKey: self.ShouldShowPinUpdateKey, defaultValue: true)
        if value != shouldShowPin {
            self.userDefaults.set(value, forKey: self.ShouldShowPinUpdateKey)
            self.userDefaults.synchronize()
        }
    }
	
	func latestBleedingTracking() -> Date? {
		let timeInterval = self.userDefaults.integer(forKey: self.LatestBleedingTrackingKey)
		if timeInterval == 0 {
			return nil
		}
		
		let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
		return date
	}
	
	func saveLatestBleedingTracking(date: Date) {
		let timeInterval = Int(date.timeIntervalSince1970)
		self.userDefaults.set(timeInterval, forKey: self.LatestBleedingTrackingKey)
		self.userDefaults.synchronize()
	}
	
	func filterItems() -> ([FilterItem], [FilterItem]) {
		var usedItems = [FilterItem]()
		var notUsedItems = [FilterItem]()
		
		if let array = self.userDefaults.array(forKey: self.UsedFilterItemsKey) {
			for itemObject in array {
				if let dict = itemObject as? [String: Any] {
					usedItems.append(self.convertToFilterItem(dict))
				}
			}
		} else {
			usedItems = [
				FilterItem(color: UIColor.eukBleeding, title: "bleeding", isOn: true),
				FilterItem(color: UIColor.eukEmotions, title: "emotions", isOn: true),
				FilterItem(color: UIColor.eukBody, title: "body", isOn: true),
				FilterItem(color: UIColor.eukSexualActivity, title: "sexual_activity", isOn: true),
				FilterItem(color: UIColor.eukContraception, title: "contraception", isOn: true),
				FilterItem(color: UIColor.eukTest, title: "test", isOn: true),
				FilterItem(color: UIColor.eukAppointment, title: "appointment", isOn: true),
				FilterItem(color: UIColor.eukNote, title: "note", isOn: true)
			]
		}
		
		if let array = self.userDefaults.array(forKey: self.NotUsedFilterItemsKey) {
			for itemObject in array {
				if let dict = itemObject as? [String: Any] {
					notUsedItems.append(self.convertToFilterItem(dict))
				}
			}
		}
		
		return (usedItems, notUsedItems)
	}
	
	func saveFilterItems(usedItems: [FilterItem], notUsedItems: [FilterItem]) {
		let usedItemsArray: [Any] = usedItems.map({ self.converFromFilterItem(item: $0) })
		let notUsedItemsArray: [Any] = notUsedItems.map({ self.converFromFilterItem(item: $0) })
		
		self.userDefaults.set(usedItemsArray, forKey: self.UsedFilterItemsKey)
		self.userDefaults.set(notUsedItemsArray, forKey: self.NotUsedFilterItemsKey)
		
		self.userDefaults.synchronize()
	}
	
	private func convertToFilterItem(_ itemDict: [String: Any]) -> FilterItem {
		let item = FilterItem()
		
		if let color = itemDict["color"] as? String, !color.isEmpty {
			item.color = UIColor.colorWithHexString(color)
		}
		if let title = itemDict["title"] as? String {
			item.title = title
		}
		if let isOn = itemDict["isOn"] as? Bool {
			item.isOn = isOn
		}
		
		return item
	}
	
	private func converFromFilterItem(item: FilterItem) -> [String: Any] {
		return [
			"color": item.color.hexString(false),
			"title": item.title,
			"isOn": item.isOn as Any
		]
	}
	
	func saveHiddenCyclePeriods(periods: [ClosedRange<Date>]) {
		var cyclesDicts = [Any]()
		
		for period in periods {
			let periodDict = [
				"start": Int(period.lowerBound.timeIntervalSince1970),
				"end": Int(period.upperBound.timeIntervalSince1970)
			]
			cyclesDicts.append(periodDict)
		}
		
		self.userDefaults.set(cyclesDicts, forKey: HiddenCyclePeriodsKey)
		self.userDefaults.synchronize()
	}
	
	func hiddenCyclePeriods() -> [ClosedRange<Date>] {
		var periods = [ClosedRange<Date>]()
		
		if let array = self.userDefaults.array(forKey: HiddenCyclePeriodsKey) {
			for periodObject in array {
				if let periodDict = periodObject as? [String: Any],
				   let startInt = periodDict["start"] as? Int,
				   let endInt = periodDict["end"] as? Int{
					let start = Date(timeIntervalSince1970: TimeInterval(startInt))
					let end = Date(timeIntervalSince1970: TimeInterval(endInt))
					periods.append(start ... end)
				}
			}
		}
		
		return periods
	}
	
	func trackPeriodEnabled() -> Bool {
		return self.userDefaults.bool(forKey: TrackPeriodEnabledKey, defaultValue: true)
	}
	
	func saveTrackPeriodEnabled(value: Bool) {
		self.userDefaults.set(value, forKey: TrackPeriodEnabledKey)
		self.userDefaults.synchronize()
	}
	
	func periodPredictionEnabled() -> Bool {
		return self.userDefaults.bool(forKey: PeriodPredictionEnabledKey, defaultValue: true)
	}
	
	func savePeriodPredictionEnabled(value: Bool) {
		self.userDefaults.set(value, forKey: PeriodPredictionEnabledKey)
		self.userDefaults.synchronize()
	}
    
    func removeAll() {
        self.userDefaults.set(nil, forKey: self.BookmarksKey)
        self.userDefaults.set(nil, forKey: self.RemindersKey)
        self.userDefaults.set(nil, forKey: self.HomeItemsUsedKey)
        self.userDefaults.set(nil, forKey: self.HomeNotItemsUsedKey)
        self.userDefaults.set(nil, forKey: self.LastDateAutoDeleteKey)
		self.userDefaults.set(nil, forKey: self.UsedFilterItemsKey)
		self.userDefaults.set(nil, forKey: self.NotUsedFilterItemsKey)
		self.userDefaults.set(nil, forKey: self.HiddenCyclePeriodsKey)
		self.userDefaults.set(nil, forKey: self.TrackPeriodEnabledKey)
		self.userDefaults.set(nil, forKey: self.PeriodPredictionEnabledKey)
        self.userDefaults.synchronize()
    }
    
    func checkMigration() {
        let allKeys = [ShowOnboardingScreensKey, PinCodeKey, BookmarksKey, RemindersKey,
                       HomeItemsUsedKey, HomeNotItemsUsedKey, RecurringDataRemovalKey,
                       LastDateAutoDeleteKey, TabBarTutorialKey, DailyLogTutorialKey,
                       CalendarTutorialKey, DailyLogCounterKey, VersionKey]
        
        if self.userDefaults.string(forKey: self.VersionKey) != nil {
            return
        }
        
        allKeys.forEach { key in
            let value = UserDefaults.standard.object(forKey: key)
            self.userDefaults.set(value, forKey: key)
            UserDefaults.standard.removeObject(forKey: key)
        }
        
        self.userDefaults.set(Bundle.main.buildVersionNumber, forKey: VersionKey)
        self.userDefaults.synchronize()
    }
}
