//
//  EUKTrackViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/14/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKTrackViewController: EUKBaseViewController {
    @IBOutlet weak var containerView: UIView!
    
    weak var logViewController: EUKLogViewController?
    weak var dailyLogViewController: EUKDailyLogViewController?
    
    weak var weekCalendarViewController: EUKWeekCalendarViewController?
    
    var date: Date?
    var calendarItem: CalendarItem?
    var expandFilterItem: FilterItem?
    var expandSelectItem: SelectItem?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let date = self.date {
            self.selectedDate(date: date, calendarItem: self.calendarItem, calendarFilter: CalendarFilter())
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let viewController = segue.destination as? EUKWeekCalendarViewController {
            self.weekCalendarViewController = viewController
			viewController.selectedDate = self.calendarItem?.date ?? self.date ?? Date()
            viewController.startDate = self.date
            viewController.delegate = self
        }
    }

    //MARK: - Actions
    
    @IBAction func doneAction(_ sender: Any) {
        if let viewController = self.logViewController {
            viewController.save { _ in
                self.performSegue(withIdentifier: self.DoneSegueIdentifier, sender: nil)
            }
        } else {
            self.performSegue(withIdentifier: self.DoneSegueIdentifier, sender: nil)
        }
    }

    //MARK: - Public
    
    class func initViewController(date: Date?, calendarItem: CalendarItem?, expandFilterItem: FilterItem? = nil, expandSelectItem: SelectItem? = nil) -> UIViewController? {
        if let navViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "NavTrackViewControlller") as? UINavigationController, let logViewContoller = navViewController.viewControllers[0] as? EUKTrackViewController {
            navViewController.modalPresentationStyle = .fullScreen
            logViewContoller.date = date
            logViewContoller.calendarItem = calendarItem
            logViewContoller.expandFilterItem = expandFilterItem
            logViewContoller.expandSelectItem = expandSelectItem
            return navViewController
        }
        
        return nil
    }
}

extension EUKTrackViewController: EUKWeekCalendarViewControllerDelegate {
	func selectedDate(date: Date, calendarItem: CalendarItem?, calendarFilter: CalendarFilter) {
		if let viewController = self.logViewController {
			viewController.save { _ in
				self.weekCalendarViewController?.refreshData()
				self.show(date: date, calendarItem: calendarItem, calendarFilter: calendarFilter)
			}
		} else {
			self.show(date: date, calendarItem: calendarItem, calendarFilter: calendarFilter)
		}
	}
    
    func show(date: Date, calendarItem: CalendarItem?, calendarFilter: CalendarFilter) {
		self.title = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.dddMMMMdd)?.capitalized
        
        self.logViewController?.removeFromParent()
        self.dailyLogViewController?.removeFromParent()
        
        if Date().daysDiff(date: date) < 0 || Calendar.current.isDateInToday(date) {
            if let viewController = EUKLogViewController.initLogViewController(date: date, calendarItem: calendarItem, expandFilterItem: expandFilterItem, expandSelectItem: expandSelectItem) as? EUKLogViewController {
				viewController.delegate = self
                self.logViewController = viewController
                self.configureChildViewController(childController: viewController, onView: self.containerView)
            }
        } else {
            if let viewController = EUKDailyLogViewController.initViewController(date: date, showTitle: false) {
                self.configureChildViewController(childController: viewController, onView: self.containerView)
            }
        }
    }
}

extension EUKTrackViewController: EUKLogViewDelegate {
	func refreshFilterItems(usedItems: [FilterItem], notUsedItems: [FilterItem]) {
		self.weekCalendarViewController?.refreshFilterItems(usedItems: usedItems, notUsedItems: notUsedItems)
	}
}
