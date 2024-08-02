//
//  Date.swift
//  Euki
//
//  Created by Víctor Chávez on 3/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

public extension Date {
    func daysDiff(date: Date) -> Int{
        let calendar = Calendar.current
        
        guard let start = calendar.ordinality(of: .day, in: .era, for: self),
              let end = calendar.ordinality(of: .day, in: .era, for: date) else{
            return 0
        }
        
        return end - start
    }
    
    func secondsDiff(date: Date) -> Int{
        let calendar = Calendar.current
        
        guard let start = calendar.ordinality(of: .second, in: .era, for: self),
            let end = calendar.ordinality(of: .second, in: .era, for: date) else{
                return 0
        }
        
        return end - start
    }
	
	func startDate() -> Date {
		let newDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)
		return newDate ?? self
	}
	
	func endDate() -> Date {
		let newDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)
		return newDate ?? self
	}
	
	func isFuture() -> Bool {
		let now = Date()
		let maxDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: now) ?? now
		return self > maxDate
	}
    
    static func numDaysMonths(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    static func dayOfWeek(year: Int, month: Int, day: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let weekDay = Calendar.current.component(.weekday, from: date)
        return weekDay
    }
    
    static func date(year: Int, month: Int) -> Date {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        return date
    }
    
    static func date(year: Int, month: Int, day: Int) -> Date {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        return date
    }
}
