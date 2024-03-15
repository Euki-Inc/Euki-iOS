//
//  CalendarManager.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import CoreData

class CalendarManager: NSObject {
    static let sharedInstance = CalendarManager()
    
    func convert(eukCalendarItem: EUKCalendarItem) -> CalendarItem {
        let calendarItem = CalendarItem()
        
        if let date = eukCalendarItem.date {
            calendarItem.date = date
        }
		calendarItem.includeCycleSummary = Int(eukCalendarItem.includeCycleSummary) == 1
        if let bleedingSize = BleedingSize(rawValue: Int(eukCalendarItem.bleedingSize)) {
            calendarItem.bleedingSize = bleedingSize
        }
		if let bleedingClotsCounter = eukCalendarItem.bleedingClotsCounter as? [Int] {
			calendarItem.bleedingClotsCounter = bleedingClotsCounter
		}
        if let bleedingProductsCounter = eukCalendarItem.bleedingProductsCounter as? [Int] {
            calendarItem.bleedingProductsCounter = bleedingProductsCounter
        }
        if let emotionsArray = eukCalendarItem.emotions as? [Int] {
            for emotionInt in emotionsArray {
                if let emotion = Emotions(rawValue: emotionInt) {
                    calendarItem.emotions.append(emotion)
                }
            }
        }
        if let bodyArray = eukCalendarItem.body as? [Int] {
            for bodyInt in bodyArray {
                if let body = Body(rawValue: bodyInt) {
                    calendarItem.body.append(body)
                }
            }
        }
        if let sexualProtectionSTICounter = eukCalendarItem.sexualProtectionSTICounter as? [Int] {
            calendarItem.sexualProtectionSTICounter = sexualProtectionSTICounter
        }
        if let sexualProtectionPregnancyCounter = eukCalendarItem.sexualProtectionPregnancyCounter as? [Int] {
            calendarItem.sexualProtectionPregnancyCounter = sexualProtectionPregnancyCounter
        }
        if let sexualOtherCounter = eukCalendarItem.sexualOtherCounter as? [Int] {
            calendarItem.sexualOtherCounter = sexualOtherCounter
        }
        if let contraceptionPill = ContraceptionPills(rawValue: Int(eukCalendarItem.contraceptionPill)) {
            calendarItem.contraceptionPill = contraceptionPill
        }
        if let contraceptionDailyOtherArray = eukCalendarItem.contraceptionDailyOther as? [Int] {
            for contraceptionDailyOtherInt in contraceptionDailyOtherArray {
                if let contraceptionDailyOther = ContraceptionDailyOther(rawValue: contraceptionDailyOtherInt) {
                    calendarItem.contraceptionDailyOther.append(contraceptionDailyOther)
                }
            }
        }
        if let contraceptionIud = ContraceptionIUD(rawValue: Int(eukCalendarItem.contraceptionIud)) {
            calendarItem.contraceptionIud = contraceptionIud
        }
        if let contraceptionImplant = ContraceptionImplant(rawValue: Int(eukCalendarItem.contraceptionImplant)) {
            calendarItem.contraceptionImplant = contraceptionImplant
        }
        if let contraceptionPatch = ContraceptionPatch(rawValue: Int(eukCalendarItem.contraceptionPatch)) {
            calendarItem.contraceptionPatch = contraceptionPatch
        }
        if let contraceptionRing = ContraceptionRing(rawValue: Int(eukCalendarItem.contraceptionRing)) {
            calendarItem.contraceptionRing = contraceptionRing
        }
        if let contraceptionLongTermOtherArray = eukCalendarItem.contraceptionLongTermOther as? [Int] {
            for contraceptionLongTermOtherInt in contraceptionLongTermOtherArray {
                if let contraceptionLongTermOther = ContraceptionLongTermOther(rawValue: contraceptionLongTermOtherInt) {
                    calendarItem.contraceptionLongTermOther.append(contraceptionLongTermOther)
                }
            }
        }
        if let contraceptionShot = ContraceptionShot(rawValue: Int(eukCalendarItem.contraceptionShot)) {
            calendarItem.contraceptionShot = contraceptionShot
        }
        if let testSTI = TestSTI(rawValue: Int(eukCalendarItem.testSTI)) {
            calendarItem.testSTI = testSTI
        }
        if let testPregnancy = TestPregnancy(rawValue: Int(eukCalendarItem.testPregnancy)) {
            calendarItem.testPregnancy = testPregnancy
        }
        if let appointments = eukCalendarItem.appointments as? [Appointment] {
            calendarItem.appointments = appointments
        }
        
        calendarItem.note = eukCalendarItem.note
        if let categories = eukCalendarItem.categories as? [FilterItem] {
            calendarItem.categories = categories
        }
        
        calendarItem.eukCalendarItem = eukCalendarItem
        return calendarItem
    }
    
    func todayCalendarItem(responseHandler: @escaping (CalendarItem?) -> Void) {
        self.calendarItem(dateSearch: Date(), responseHandler: responseHandler)
    }
    
    func calendarItem(dateSearch: Date, responseHandler: @escaping (CalendarItem?) -> Void) {
		let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EUKCalendarItem>(entityName: "EUKCalendarItem")
        do {
            let eukCalendarItems = try managedContext.fetch(fetchRequest)
            for eukCalendarItem in eukCalendarItems {
                if let date = eukCalendarItem.date, Calendar.current.isDate(date, inSameDayAs: dateSearch) {
                    let calendarItem = self.convert(eukCalendarItem: eukCalendarItem)
                    responseHandler(calendarItem)
                    return
                }
            }
            responseHandler(nil)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            responseHandler(nil)
        }
    }
    
    func calendarItem(dateSearch: Date) -> CalendarItem? {
		let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EUKCalendarItem>(entityName: "EUKCalendarItem")
        do {
            let eukCalendarItems = try managedContext.fetch(fetchRequest)
            for eukCalendarItem in eukCalendarItems {
                if let date = eukCalendarItem.date, Calendar.current.isDate(date, inSameDayAs: dateSearch) {
                    let calendarItem = self.convert(eukCalendarItem: eukCalendarItem)
                    return calendarItem
                }
            }
            return nil
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func requestItems(responseHandler: @escaping ([String: CalendarItem]) -> Void) {
        let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EUKCalendarItem>(entityName: "EUKCalendarItem")
        do {
            let eukCalendarItems = try managedContext.fetch(fetchRequest)
            var calendarItems = [String: CalendarItem]()
            for eukCalendarItem in eukCalendarItems {
                let calendarItem = self.convert(eukCalendarItem: eukCalendarItem)
                if let dateString = DateManager.sharedInstance.string(date: calendarItem.date, format: DateManager.sharedInstance.DateLongFormat) {
                    calendarItems[dateString] = calendarItem
                }
            }
            responseHandler(calendarItems)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            responseHandler([String: CalendarItem]())
        }
    }
    
	func requestDayItems(ascending: Bool = false, responseHandler: @escaping ([CalendarItem]) -> Void) {
        let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EUKCalendarItem>(entityName: "EUKCalendarItem")
        let sort = NSSortDescriptor(key: #keyPath(EUKCalendarItem.date), ascending: ascending)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let eukCalendarItems = try managedContext.fetch(fetchRequest)
            var calendarItems = [CalendarItem]()
            for eukCalendarItem in eukCalendarItems {
                let calendarItem = self.convert(eukCalendarItem: eukCalendarItem)
                if calendarItem.hasData() {
                    calendarItems.append(calendarItem)
                }
            }
            responseHandler(calendarItems)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            responseHandler([CalendarItem]())
        }
    }
    
    func saveItem(appointment: Appointment, responseHandler: @escaping (Bool) -> Void) {
        let allCategories = [
            FilterItem(color: UIColor.eukBleeding, title: "bleeding", isOn: true),
            FilterItem(color: UIColor.eukEmotions, title: "emotions", isOn: true),
            FilterItem(color: UIColor.eukBody, title: "body", isOn: true),
            FilterItem(color: UIColor.eukSexualActivity, title: "sexual_activity", isOn: true),
            FilterItem(color: UIColor.eukContraception, title: "contraception", isOn: true),
            FilterItem(color: UIColor.eukTest, title: "test", isOn: true),
            FilterItem(color: UIColor.eukAppointment, title: "appointment", isOn: true),
            FilterItem(color: UIColor.eukNote, title: "note", isOn: true)
        ]
        
        self.saveItem(appointment: appointment, allCategories: allCategories, responseHandler: responseHandler)
    }
    
    func saveItem(appointment: Appointment, allCategories: [FilterItem], responseHandler: @escaping (Bool) -> Void) {
        var calendarItem = CalendarItem()
        
        guard let date = appointment.date else {
            responseHandler(false)
            return
        }
        
        self.calendarItem(dateSearch: date) { (foundItem) in
            if let foundItem = foundItem {
                calendarItem = foundItem
            } else {
                calendarItem.date = date
                calendarItem.categories = allCategories
            }
            
            calendarItem.appointments.append(appointment)
            self.saveItem(calendarItem: calendarItem, responseHandler: responseHandler)
        }
    }
    
    func saveItem(calendarItem: CalendarItem, responseHandler: @escaping (Bool) -> Void) {
        var appointments = [Appointment]()
        var otherDaysAppointments = [Appointment]()
        
        for appointment in calendarItem.appointments {
            if let appointmentDate = appointment.date {
                if Calendar.current.isDate(calendarItem.date, inSameDayAs: appointmentDate) {
                    appointments.append(appointment)
                } else {
                    otherDaysAppointments.append(appointment)
                }
            }
        }
        
        for otherDayAppointment in otherDaysAppointments {
            if let otherDate = otherDayAppointment.date {
                let calendarItem = self.calendarItem(dateSearch: otherDate) ?? CalendarItem(date: otherDate)
                if calendarItem.eukCalendarItem == nil {
                    calendarItem.categories = [
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
                calendarItem.appointments.append(otherDayAppointment)
                self.saveItem(calendarItem: calendarItem) { (success) in
                    print("Saved Other!!")
                }
            }
        }
        
        calendarItem.appointments = appointments
        
        let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        var eukCalendarItem: EUKCalendarItem
        if let item = calendarItem.eukCalendarItem {
            eukCalendarItem = item
        } else {
            if let entity = NSEntityDescription.entity(forEntityName: "EUKCalendarItem", in: managedContext), let item = NSManagedObject(entity: entity, insertInto: managedContext) as? EUKCalendarItem {
                eukCalendarItem = item
            } else {
                eukCalendarItem = EUKCalendarItem()
            }
        }
        
        eukCalendarItem.date = calendarItem.date
		eukCalendarItem.includeCycleSummary = Int16(calendarItem.includeCycleSummary ? 1 : 0)
        eukCalendarItem.bleedingSize = Int16(calendarItem.bleedingSize?.rawValue ?? -1)
		eukCalendarItem.bleedingClotsCounter = calendarItem.bleedingClotsCounter as NSObject
        eukCalendarItem.bleedingProductsCounter = calendarItem.bleedingProductsCounter as NSObject
        eukCalendarItem.emotions = calendarItem.emotions.map({$0.rawValue}) as NSObject
        eukCalendarItem.body = calendarItem.body.map({$0.rawValue}) as NSObject
        eukCalendarItem.sexualProtectionSTICounter = calendarItem.sexualProtectionSTICounter as NSObject
        eukCalendarItem.sexualProtectionPregnancyCounter = calendarItem.sexualProtectionPregnancyCounter as NSObject
        eukCalendarItem.sexualOtherCounter = calendarItem.sexualOtherCounter as NSObject
        eukCalendarItem.contraceptionPill = Int16(calendarItem.contraceptionPill?.rawValue ?? -1)
        eukCalendarItem.contraceptionDailyOther = calendarItem.contraceptionDailyOther.map({$0.rawValue}) as NSObject
        eukCalendarItem.contraceptionIud = Int16(calendarItem.contraceptionIud?.rawValue ?? -1)
        eukCalendarItem.contraceptionImplant = Int16(calendarItem.contraceptionImplant?.rawValue ?? -1)
        eukCalendarItem.contraceptionPatch = Int16(calendarItem.contraceptionPatch?.rawValue ?? -1)
        eukCalendarItem.contraceptionRing = Int16(calendarItem.contraceptionRing?.rawValue ?? -1)
        eukCalendarItem.contraceptionShot = Int16(calendarItem.contraceptionShot?.rawValue ?? -1)
        eukCalendarItem.contraceptionLongTermOther = calendarItem.contraceptionLongTermOther.map({$0.rawValue}) as NSObject
        eukCalendarItem.testSTI = Int16(calendarItem.testSTI?.rawValue ?? -1)
        eukCalendarItem.testPregnancy = Int16(calendarItem.testPregnancy?.rawValue ?? -1)
        eukCalendarItem.appointments = calendarItem.appointments as NSObject
        eukCalendarItem.note = calendarItem.note
        eukCalendarItem.categories = calendarItem.categories as NSObject
        
        do {
            try managedContext.save()
            
            for appointment in calendarItem.appointments {
                self.updateLocalNotification(appointment: appointment)
            }
            
            responseHandler(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            responseHandler(false)
        }
    }
    
    func updateLocalNotification(appointment: Appointment) {
        guard let id = appointment.id else {
            return
        }
        
        LocalNotificationManager.sharedInstance.deleteNotification(id: id)

        if let alertDate = appointment.alertDate() {
            LocalNotificationManager.sharedInstance.createNotification(id: id, date: alertDate) { (_) in
            }
        }
    }
    
    func pendingNotify(responseHandler: @escaping (Appointment?) -> Void) {
        self.calendarItem(dateSearch: Date()) { (calendarItem) in
            guard let calendarItem = calendarItem else {
                responseHandler(nil)
                return
            }
            
            for (index, appointment) in calendarItem.appointments.enumerated() {
                if let _ = appointment.alertShown {
                    responseHandler(nil)
                    continue
                }
                
                let currentDate = Date()
                if let appointmentDate = appointment.date, let alertDate = appointment.alertDate(), alertDate < currentDate, currentDate < appointmentDate {
                    appointment.alertShown = 1
                    var appointments = calendarItem.appointments
                    appointments[index] = appointment
                    calendarItem.appointments = appointments
                
                    self.saveItem(calendarItem: calendarItem, responseHandler: { (_) in
                        responseHandler(appointment)
                    })
                    return
                }
            }
            
            responseHandler(nil)
        }
    }
	
	func shouldShowIncludeCycleAlert(date: Date) -> Bool {
		guard let date = LocalDataManager.sharedInstance.latestBleedingTracking() else {
			return true
		}
		
		return date.daysDiff(date: date.startDate()) >= Constants.DaysBleedingTrackingAlert
	}
	
	func updateLatestBleedingTracking(date: Date) {
		let checkDate = date.startDate()
		
		guard let currentDate = LocalDataManager.sharedInstance.latestBleedingTracking() else {
			LocalDataManager.sharedInstance.saveLatestBleedingTracking(date: checkDate)
			return
		}
		
		if currentDate < checkDate {
			LocalDataManager.sharedInstance.saveLatestBleedingTracking(date: checkDate)
		}
	}
	
	func predictionRange(responseHandler: @escaping ([ClosedRange<Date>]) -> Void) {
		if !LocalDataManager.sharedInstance.periodPredictionEnabled() {
			responseHandler([ClosedRange<Date>]())
			return
		}
		
		CycleManager.sharedInstance.requestCyclePeriodData { data in
			var ranges = [ClosedRange<Date>]()
			
			if let averageCycleLength = data.averageCycleLength, let averagePeriodLength = data.averagePeriodLength, let startDate = data.items.first?.initialDate {
				for index in 1 ... 4 {
					let start = Calendar.current.date(byAdding: .day, value: index * Int(averageCycleLength), to: startDate) ?? Date()
					let end = Calendar.current.date(byAdding: .day, value: Int(averagePeriodLength - 1), to: start) ?? Date()
					ranges.append(start ... end)
				}
			}
			
			responseHandler(ranges)
		}
	}
    
    func removeAll() {
		let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EUKCalendarItem>(entityName: "EUKCalendarItem")
        do {
            let eukCalendarItems = try managedContext.fetch(fetchRequest)
            for eukCalendarItem in eukCalendarItems {
                managedContext.delete(eukCalendarItem)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
