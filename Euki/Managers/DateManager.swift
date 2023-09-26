//
//  DateManager.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class DateManager {
    static let sharedInstance = DateManager()
    let DateLongFormat = "MMMM dd, yyyy"
    let DateTimeLongFormat = "yyyyMMddhhmmss"
    let TimeFormat = "h:mma"
    let CalendarFormat = "MMMM yyyy"
    let dddMMMMdd = "EEE, MMMM dd"
	let EEEMMMdd = "EEE, MMM dd"
    let eeeMMMdyyyyhmma = "EEE, MMM d, yyyy h:mm a"
    let eee = "EEE"
	let eeedd = "EEE dd"
	let MMMdd = "MMM dd"
    
    fileprivate var dateFormatter: DateFormatter
    fileprivate var componentsFormatter: DateComponentsFormatter
    
    //MARK: - Instance methods
    
    init(){
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.DateLongFormat
        
        componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .full
    }
    
    func stringDateFromUnix(_ dateUnix: UInt64) -> String{
        self.dateFormatter.dateFormat = self.DateLongFormat
        
        let dateDouble = Double(dateUnix)
        let date = Date(timeIntervalSince1970: dateDouble/1000)
        return self.dateFormatter.string(from: date)
    }
    
    func stringDateFromUnix(_ dateUnix: UInt64, dateFormat format: String) -> String{
        self.dateFormatter.dateFormat = format
        
        let dateDouble = Double(dateUnix)
        let date = Date(timeIntervalSince1970: dateDouble/1000)
        return self.dateFormatter.string(from: date)
    }
    
    func stringTimeFromUnix(_ dateUnix: UInt64) -> String{
        self.dateFormatter.dateFormat = self.TimeFormat
        
        let dateDouble = Double(dateUnix)
        let date = Date(timeIntervalSince1970: dateDouble/1000)
        return self.dateFormatter.string(from: date)
    }
    
    func dateFromString(_ dateString: String) -> Date?{
        return self.dateFormatter.date(from: dateString)
    }
    
    func date(_ dateString: String, _ format: String) -> Date?{
        self.dateFormatter.dateFormat = format
        return self.dateFormatter.date(from: dateString)
    }
    
    func abbreviatedStringFromInterval(_ dateUnix: UInt) -> String?{
        let diffInterval = Double(dateUnix)
        
        return componentsFormatter.string(from: diffInterval)
    }
    
    func imageFileString() -> String{
        let date = Date()
        self.dateFormatter.dateFormat = self.DateTimeLongFormat
        return "\(self.dateFormatter.string(from: date))-ios.JPG"
    }
    
    func string(date: Date, format: String) -> String? {
        self.dateFormatter.dateFormat = format
        return self.dateFormatter.string(from: date)
    }
}
