//
//  CycleDayItem.swift
//  Euki
//
//  Created by Víctor Chávez on 6/10/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class CycleDayItem: NSObject {
	var date: Date
	var dayCycle: Int?
	var dateNextCycle: Date?
	var calendarItem: CalendarItem?
	
	init(date: Date, dayCycle: Int? = nil, dateNextCycle: Date? = nil, calendarItem: CalendarItem? = nil) {
		self.date = date
		self.dayCycle = dayCycle
		self.dateNextCycle = dateNextCycle
		self.calendarItem = calendarItem
	}
	
	func isToday() -> Bool {
		Calendar.current.isDateInToday(self.date)
	}
}
