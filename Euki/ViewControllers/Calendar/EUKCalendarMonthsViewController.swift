//
//  EUKCalendarMonthsViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCalendarMonthsViewController: EUKBaseCalendarViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Private
    
    override func selectedDate(date: Date, calendarItem: CalendarItem?) {
        if let dailyLogViewController = EUKDailyLogViewController.initViewController(date: date) {
            self.navigationController?.pushViewController(dailyLogViewController, animated: true)
        }
    }
    
    //MARK: - Public
    
    class func initViewController() -> EUKCalendarMonthsViewController? {
        if let viewController = super.initViewController(anyClass: EUKCalendarMonthsViewController.self) as? EUKCalendarMonthsViewController {
            return viewController
        }
        return nil
    }

}
