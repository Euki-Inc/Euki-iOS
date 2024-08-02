//
//  CalendarItem.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class CalendarItem: NSObject {
    var date: Date
	var includeCycleSummary: Bool
    var bleedingSize: BleedingSize?
	var bleedingClotsCounter: [Int]
    var bleedingProductsCounter: [Int]
    var emotions: [Emotions]
    var body: [Body]
    var sexualProtectionSTICounter: [Int]
    var sexualProtectionPregnancyCounter: [Int]
    var sexualOtherCounter: [Int]
    var contraceptionPill: ContraceptionPills?
    var contraceptionDailyOther: [ContraceptionDailyOther]
    var contraceptionIud: ContraceptionIUD?
    var contraceptionImplant: ContraceptionImplant?
    var contraceptionPatch: ContraceptionPatch?
    var contraceptionRing: ContraceptionRing?
    var contraceptionLongTermOther: [ContraceptionLongTermOther]
    var contraceptionShot: ContraceptionShot?
    var testSTI: TestSTI?
    var testPregnancy: TestPregnancy?
    var appointments: [Appointment]
    var note: String?
    var categories: [FilterItem]
    var eukCalendarItem: EUKCalendarItem?
    
    override init() {
        self.date = Date()
		
		self.includeCycleSummary = false
		
		self.bleedingClotsCounter = [Int]()
		for _ in 1 ... 2 {
			self.bleedingClotsCounter.append(0)
		}
        
        self.bleedingProductsCounter = [Int]()
        for _ in 1 ... 7 {
            self.bleedingProductsCounter.append(0)
        }
        
        self.emotions = [Emotions]()
        self.body = [Body]()
        
        self.sexualProtectionSTICounter = [Int]()
        for _ in 1 ... 2 {
            self.sexualProtectionSTICounter.append(0)
        }
        self.sexualProtectionPregnancyCounter = [Int]()
        for _ in 1 ... 2 {
            self.sexualProtectionPregnancyCounter.append(0)
        }
        self.sexualOtherCounter = [Int]()
        for _ in 1 ... 5 {
            self.sexualOtherCounter.append(0)
        }

        self.contraceptionDailyOther = [ContraceptionDailyOther]()
        self.contraceptionLongTermOther = [ContraceptionLongTermOther]()
        self.appointments = [Appointment]()
        self.categories = [FilterItem]()
    }
    
    convenience init(date: Date) {
        self.init()
        self.date = date
    }
    
    func hasBleeding() -> Bool {
		for count in self.bleedingClotsCounter {
			if count > 0 {
				return true
			}
		}
        for count in self.bleedingProductsCounter {
            if count > 0 {
                return true
            }
        }
        return self.bleedingSize != nil
    }
	
	func hasPeriod() -> Bool {
		if !self.includeCycleSummary {
			return false
		}
		
		for count in self.bleedingClotsCounter {
			if count > 0 {
				return true
			}
		}
		return self.bleedingSize != nil
	}
	
	func bleedingCount() -> Int {
		var count = 0
		
		if self.bleedingSize != nil {
			count += 1
		}
		self.bleedingClotsCounter.forEach { value in
			if value > 0 {
				count += 1
			}
		}
		
		return count
	}
    
    func hasEmotions() -> Bool {
        return self.emotions.count > 0
    }
    
    func hasBody() -> Bool {
        return self.body.count > 0
    }
    
    func hasSexualActivity() -> Bool {
        for count in self.sexualProtectionSTICounter {
            if count > 0 {
                return true
            }
        }
        for count in self.sexualProtectionPregnancyCounter {
            if count > 0 {
                return true
            }
        }
        for count in self.sexualOtherCounter {
            if count > 0 {
                return true
            }
        }
        
        return false
    }
	
	func sexualActivityCount() -> Int {
		var count = 0
		
		self.sexualProtectionSTICounter.forEach { value in
			if value > 0 {
				count += 1
			}
		}
		self.sexualProtectionPregnancyCounter.forEach { value in
			if value > 0 {
				count += 1
			}
		}
		self.sexualOtherCounter.forEach { value in
			if value > 0 {
				count += 1
			}
		}
		
		return count
	}
    
    func hasContraception() -> Bool {
        return self.contraceptionPill != nil || self.contraceptionDailyOther.count > 0 || self.contraceptionIud != nil || self.contraceptionImplant != nil || self.contraceptionPatch != nil || self.contraceptionRing != nil || self.contraceptionLongTermOther.count > 0 || self.contraceptionShot != nil
    }
	
	func contraceptionCount() -> Int {
		var count = 0
		
		if self.contraceptionPill != nil {
			count += 1
		}
		if !self.contraceptionDailyOther.isEmpty {
			count += 1
		}
		if self.contraceptionIud != nil {
			count += 1
		}
		if self.contraceptionImplant != nil {
			count += 1
		}
		if self.contraceptionPatch != nil {
			count += 1
		}
		if self.contraceptionRing != nil {
			count += 1
		}
		if !self.contraceptionLongTermOther.isEmpty {
			count += 1
		}
        if self.contraceptionShot != nil {
            count += 1
        }
		return count
	}
    
    func hasTest() -> Bool {
        return self.testSTI != nil || self.testPregnancy != nil
    }
	
	func testCount() -> Int {
		var count = 0
		
		if self.testSTI != nil {
			count += 1
		}
		if self.testPregnancy != nil {
			count += 1
		}
		
		return count
	}
    
    func hasAppointment() -> Bool {
        return self.appointments.count > 0
    }
    
    func hasNote() -> Bool {
        return self.note != nil
    }
    
    func hasData() -> Bool {
        return self.hasBleeding() || self.hasEmotions() || self.hasBody() || self.hasSexualActivity() || self.hasContraception() || self.hasTest() || self.hasAppointment() || self.hasNote()
    }
	
	func dataCount() -> Int {
        
		return self.bleedingCount() +
            self.bleedingProductsCounter.reduce(0, +) +
			self.emotions.count +
			self.body.count +
			self.sexualActivityCount() +
			self.contraceptionCount() +
			self.testCount() +
			(self.hasAppointment() ? 1 : 0) +
			(self.hasNote() ? 1 : 0)
	}
}
