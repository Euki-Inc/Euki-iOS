//
//  CalendarFilter.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class CalendarFilter: NSObject {
    var bleedingOn = false
    var emotionsOn = false
    var bodyOn = false
    var sexualActivityOn = false
    var contraceptionOn = false
    var testOn = false
    var appointmentOn = false
    var noteOn = false
    
    func showAll() -> Bool {
        if self.bleedingOn && self.emotionsOn && self.bodyOn && self.sexualActivityOn && self.contraceptionOn && self.testOn && self.appointmentOn && self.noteOn {
            return true
        }
        if !self.bleedingOn && !self.emotionsOn && !self.bodyOn && !self.sexualActivityOn && !self.contraceptionOn && !self.testOn && !self.appointmentOn && !self.noteOn {
            return true
        }
        return false
    }
    
    func counter() -> Int {
        var count = 0
        if self.bleedingOn {
            count += 1
        }
        if self.emotionsOn {
            count += 1
        }
        if self.bodyOn {
            count += 1
        }
        if self.sexualActivityOn {
            count += 1
        }
        if self.contraceptionOn {
            count += 1
        }
        if self.testOn {
            count += 1
        }
        if self.appointmentOn {
            count += 1
        }
        if self.noteOn {
            count += 1
        }
        return count
    }
}
