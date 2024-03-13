//
//  CycleManager.swift
//  Euki
//
//  Created by Víctor Chávez on 6/10/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class CycleManager: NSObject {
	static let sharedInstance = CycleManager()
		
	func requestCycleItems(responseHandler: @escaping ([CycleDayItem]) -> Void) {
		DispatchQueue.global(qos: .background).async {
			CalendarManager.sharedInstance.requestDayItems { calendarItems in
				var dict = [Date: CalendarItem]()

				calendarItems.forEach { item in
					dict[item.date.startDate()] = item
				}

				self.generateCycleItems(dict: dict) { items in
					DispatchQueue.main.async {
						responseHandler(items)
					}
				}
			}
		}
	}
	
	private func generateCycleItems(dict: [Date: CalendarItem], responseHandler: @escaping ([CycleDayItem]) -> Void) {
		let trackPeriodEnabled = LocalDataManager.sharedInstance.trackPeriodEnabled()
		
		CalendarManager.sharedInstance.predictionRange { predictionRanges in
			let nextPredictionDate = predictionRanges.first?.lowerBound
			let today = Date().startDate()
			
			var items = [CycleDayItem]()
			
			let endDate = Date().startDate()
			let startDate = Calendar.current.date(byAdding: .year, value: -3, to: endDate) ?? Date()
			
			var currentDate = startDate
			
			var currentDayCycle = 0
			var emptyDays = 0
			
			while currentDate <= endDate {
				let calendarItem = dict[currentDate]
				let hasPeriod = calendarItem?.hasPeriod() ?? false
				let isNextPeriod = emptyDays >= Constants.MinDaysBetweenPeriods
				
				if hasPeriod {
					emptyDays = 0
				} else {
					emptyDays += 1
				}
				
				if hasPeriod && isNextPeriod {
					currentDayCycle = 1
				} else if currentDayCycle > 0 {
					currentDayCycle += 1
				}
				
				let dateNextCycle: Date?
				
				if Calendar.current.isDate(today, inSameDayAs: currentDate) && isNextPeriod {
					dateNextCycle = nextPredictionDate
				} else {
					dateNextCycle = nil
				}
				
				let item = CycleDayItem(date: currentDate, dayCycle: (!trackPeriodEnabled || currentDayCycle == 0) ? nil : currentDayCycle, dateNextCycle: dateNextCycle, calendarItem: calendarItem)
				items.append(item)
				
				currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? Date()
			}
			
			responseHandler(items)
		}
	}
	
	func convert(calendarItem: CalendarItem) -> [SelectItem] {
		var selectItems = [SelectItem]()
		
		//Bleeding Items
		
		if let bleedingSize = calendarItem.bleedingSize {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: bleedingSize), title: ConstansManager.sharedInstance.text(for: bleedingSize)))
		}
		for (index, value) in calendarItem.bleedingClotsCounter.enumerated() {
			if value > 0 {
				if let bleedingClot = BleedingClot(rawValue: index) {
					let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: bleedingClot), title: ConstansManager.sharedInstance.text(for: bleedingClot))
					selectItem.count = value
					selectItems.append(selectItem)
				}
			}
		}
		for (index, value) in calendarItem.bleedingProductsCounter.enumerated() {
			if value > 0 {
				if let bleedingProduct = BleedingProducts(rawValue: index) {
					let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: bleedingProduct), title: ConstansManager.sharedInstance.text(for: bleedingProduct))
					selectItem.count = value
					selectItems.append(selectItem)
				}
			}
		}
		
		//Emotions Items
		
		for emotion in calendarItem.emotions {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: emotion), title: ConstansManager.sharedInstance.text(for: emotion)))
		}
		
		//Body Items
		
		for body in calendarItem.body {
			if body == .stomachache {
				selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: body), title: "body_12_break".localized))
			} else {
				selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: body), title: ConstansManager.sharedInstance.text(for: body)))
			}
		}
		
		//Sexual Activity Items
		
		for (index, value) in calendarItem.sexualProtectionSTICounter.enumerated() {
			if value > 0 {
				if let sexualActivity = SexualProtectionSTI(rawValue: index) {
					let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: sexualActivity), title: ConstansManager.sharedInstance.textList(for: sexualActivity))
					selectItem.count = value
					selectItems.append(selectItem)
				}
			}
		}
		for (index, value) in calendarItem.sexualProtectionPregnancyCounter.enumerated() {
			if value > 0 {
				if let sexualActivity = SexualProtectionPregnancy(rawValue: index) {
					let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: sexualActivity), title: ConstansManager.sharedInstance.textList(for: sexualActivity))
					selectItem.count = value
					selectItems.append(selectItem)
				}
			}
		}
		for (index, value) in calendarItem.sexualOtherCounter.enumerated() {
			if value > 0 {
				if let sexualActivity = SexualProtectionOther(rawValue: index) {
					let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: sexualActivity), title: ConstansManager.sharedInstance.text(for: sexualActivity))
					selectItem.count = value
					selectItems.append(selectItem)
				}
			}
		}
		
		//Contraception Items
		
		if let contraception = calendarItem.contraceptionIud {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
		}
		if let contraception = calendarItem.contraceptionPill {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
		}
		if let contraception = calendarItem.contraceptionRing {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
		}
		if let contraception = calendarItem.contraceptionPatch {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
		}
		if let contraception = calendarItem.contraceptionImplant {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
		}
		for contraception in calendarItem.contraceptionDailyOther {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.text(for: contraception)))
		}
		for contraception in calendarItem.contraceptionLongTermOther {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.text(for: contraception)))
		}
        
        for contraception in calendarItem.contraceptionShot {
            selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.text(for: contraception)))
        }
        
		
		//Test Items
		
		if let test = calendarItem.testSTI {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: test), title: ConstansManager.sharedInstance.textList(for: test)))
		}
		if let test = calendarItem.testPregnancy {
			selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: test), title: ConstansManager.sharedInstance.textList(for: test)))
		}
		
		//Apointment Item
		
		if calendarItem.hasAppointment() {
			selectItems.append(SelectItem(imageName: "IconTrackingAppointment", title: "appointment"))
		}
		
		//Note Item
		
		if calendarItem.hasNote() {
			selectItems.append(SelectItem(imageName: "IconTrackingNote", title: "note"))
		}
		
		return selectItems
	}
	
	func requestCyclePeriodData(responseHandler: @escaping (CyclePeriodData) -> Void) {
		if !LocalDataManager.sharedInstance.trackPeriodEnabled() {
			responseHandler(CyclePeriodData(averageCycleLength: nil, variation: nil, averagePeriodLength: nil, currentDayCycle: nil, maxCycleLength: nil, items: [CyclePeriodItem]()))
			return
		}
		
		DispatchQueue.global(qos: .background).async {
			CalendarManager.sharedInstance.requestDayItems(ascending: true) { calendarItems in
				DispatchQueue.main.async {
					responseHandler(self.convert(calendarItems: calendarItems))
				}
			}
		}
	}
	
	func convert(calendarItems: [CalendarItem]) -> CyclePeriodData {
		let items = calendarItems.filter({ $0.includeCycleSummary })
		var periodItems = [CyclePeriodItem]()
		
		var currentStartDate = (items.first?.date ?? Date()).startDate()
		var currentDuration = 0
		
		for calendarItem in items {
			let daysDiff = currentStartDate.daysDiff(date: calendarItem.date)
			
			if daysDiff > 14 {
				let endDate = Calendar.current.date(byAdding: .day, value: daysDiff - 1, to: currentStartDate) ?? Date()
				let periodItem = CyclePeriodItem(initialDate: currentStartDate, endDate: endDate, duration: currentDuration + 1)
				periodItems.append(periodItem)
				
				currentStartDate = calendarItem.date
				currentDuration = 0
			} else {
				currentDuration = daysDiff
			}
		}
		
		// Remove hidden periods
		
		let hiddenPeriods = LocalDataManager.sharedInstance.hiddenCyclePeriods()
		
		periodItems = periodItems.filter { item in
			let itemRange = item.initialDate ... item.endDate
			
			for hiddenPeriod in hiddenPeriods {
				if itemRange.overlaps(hiddenPeriod) {
					return false
				}
			}
			
			return true
		}
		
		// Average Cycle Length calculation
		var averageItems = [CyclePeriodItem]()
		if periodItems.count > 4 {
			for index in periodItems.count - 5 ... periodItems.count - 1 {
				averageItems.append(periodItems[index])
			}
		} else {
			averageItems.append(contentsOf: periodItems)
		}
		
		var averageCycleLength: Double? = nil
		if !averageItems.isEmpty {
			let sum = averageItems.map({ $0.initialDate.daysDiff(date: $0.endDate) }).reduce(0, +)
			let length = averageItems.count
			averageCycleLength = Double(sum)/Double(length)
		}
		
		// Variation calculation
		var variation: Int? = nil
		let periodItemsLength = periodItems.map({ $0.initialDate.daysDiff(date: $0.endDate) })
		if let max = periodItemsLength.max(), let min = periodItemsLength.min() {
			variation = max - min
		}
		
		// Average Period Length calculation
		var averagePeriodLength: Double? = nil
		if !periodItems.isEmpty {
			let sum = averageItems.map({ $0.duration }).reduce(0, +)
			let length = averageItems.count
			averagePeriodLength = Double(sum)/Double(length)
		}
		
		// Max Length calculation
		
		let maxCycleLength = periodItems.map({ $0.initialDate.daysDiff(date: $0.endDate) + 1 }).max()
		
		// Current Day Cycle calculation
		
		var currentDayCycle: Int? = nil
		if !items.isEmpty {
			let endDate = Date()
			let daysDiff = currentStartDate.daysDiff(date: endDate) + 1
			
			let periodItem = CyclePeriodItem(initialDate: currentStartDate, endDate: endDate, duration: currentDuration + 1)
			periodItems.append(periodItem)
			currentDayCycle = daysDiff
		}
		
		periodItems.sort(by: { $0.initialDate > $1.initialDate })
		
		return CyclePeriodData(averageCycleLength: averageCycleLength, variation: variation, averagePeriodLength: averagePeriodLength, currentDayCycle: currentDayCycle, maxCycleLength: maxCycleLength, items: periodItems)
	}
	
	func deletePeriod(item: CyclePeriodItem, responseHandler: @escaping (Bool) -> Void) {
		var hiddenPeriods = LocalDataManager.sharedInstance.hiddenCyclePeriods()
		hiddenPeriods.append(item.initialDate ... item.endDate)
		LocalDataManager.sharedInstance.saveHiddenCyclePeriods(periods: hiddenPeriods)
		responseHandler(true)
	}
}
