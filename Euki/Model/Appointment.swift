//
//  Appointment.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class Appointment: NSObject, NSCoding {
    var id: String?
    var title: String?
    var location: String?
    var date: Date?
    var alertOption: Int?
    var alertShown: Int?
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.location = aDecoder.decodeObject(forKey: "location") as? String
        self.date = aDecoder.decodeObject(forKey: "date") as? Date
        self.alertOption = aDecoder.decodeObject(forKey: "alertOption") as? Int
        self.alertShown = aDecoder.decodeObject(forKey: "alertShown") as? Int
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.location, forKey: "location")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.alertOption, forKey: "alertOption")
        aCoder.encode(self.alertShown, forKey: "alertShown")
    }
    
    func alertDate() -> Date? {
        guard let alertOption = self.alertOption, let date = self.date else {
            return nil
        }
        
        var alertDate: Date?
        switch alertOption {
        case 1:
            alertDate = Calendar.current.date(byAdding: .minute, value: -30, to: date)
        case 2 ... 4:
            alertDate = Calendar.current.date(byAdding: .hour, value: -1 * (alertOption - 1), to: date)
        case 5 ... 7:
            alertDate = Calendar.current.date(byAdding: .day, value: -1 * (alertOption - 4), to: date)
        default:
            break
        }
        
        return alertDate
    }
}
