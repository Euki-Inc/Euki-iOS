//
//  EUKCalendarTabViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCalendarTabViewController: EUKBasePinCheckViewController {
    let FilterSegueIdentifier = "FilterSegueIdentifier"
    
    @IBOutlet weak var containerView: UIView!
	@IBOutlet weak var tutorialView: UIView!
    
    var calendarFilter = CalendarFilter()
	var currentViewController: UIViewController?
	
	var reminderNavItem: EUKNavItemView?
	var filterNavItem: EUKNavItemView?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
		self.showViewController(index: 0)
		self.tutorialView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		if LocalDataManager.sharedInstance.shouldShowCalendarTutorial() {
			self.tutorialView.isHidden = false
		}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navViewController = segue.destination as? UINavigationController, let filterViewController = navViewController.viewControllers.first as? EUKCalendarFilterViewController {
            filterViewController.calendarFilter = calendarFilter
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func filtersAction() {
        self.performSegue(withIdentifier: self.FilterSegueIdentifier, sender: nil)
    }
    
    @IBAction func remindersAction() {
        let viewController = UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(withIdentifier: "NavRemindersViewController")
		viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
	
	@IBAction func hideTutorialView(_ sender: Any) {
		self.tutorialView.isHidden = true
	}
    
    //MARK: - Private
    
    func setUIElements() {
		if let reminderNavItem = EUKNavItemView.initView() {
			reminderNavItem.button.addTarget(self, action: #selector(EUKCalendarTabViewController.remindersAction), for: .touchUpInside)
			self.reminderNavItem = reminderNavItem
		}
		
		if let filterNavItem = EUKNavItemView.initView() {
			filterNavItem.button.addTarget(self, action: #selector(EUKCalendarTabViewController.filtersAction), for: .touchUpInside)
			self.filterNavItem = filterNavItem
		}
    }
    
	func showViewController(index: Int) {
		self.currentViewController?.removeFromParent()
		
        if index == 0 {
            if let viewController = EUKCalendarMonthsViewController.initViewController() {
                viewController.calendarFilter = self.calendarFilter
                self.configureChildViewController(childController: viewController, onView: self.containerView)
				self.currentViewController = viewController
            }
        } else {
            if let viewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKCalendarListViewController.ViewControllerID) as? EUKCalendarListViewController {
                viewController.calendarFilter = self.calendarFilter
                self.configureChildViewController(childController: viewController, onView: self.containerView)
				self.currentViewController = viewController
            }
        }
    }
    
    func showNavItems() {
		if let reminderNavItem = self.reminderNavItem {
			let remindersCount = LocalDataManager.sharedInstance.reminders().count
			var countString = ""
			if remindersCount > 0 {
				countString = "(\(remindersCount))"
			}
			
			let title = "\("reminders".localized.uppercased()) \(countString)"
			
			reminderNavItem.blurView.isHidden = remindersCount == 0
			reminderNavItem.button.setTitle(title, for: .normal)
			
			let leftBarItem = UIBarButtonItem(customView: reminderNavItem)
			self.navigationItem.leftBarButtonItem = leftBarItem
		}
		
		if let filterNavItem = self.filterNavItem {
			let filtersCount = self.calendarFilter.counter()
			var countString = ""
			if filtersCount > 0 && filtersCount < 8 {
				countString = "(\(filtersCount))"
			}
			
			let title = "\("filter".localized.uppercased()) \(countString)"
			
			filterNavItem.blurView.isHidden = filtersCount == 0
			filterNavItem.button.setTitle(title, for: .normal)
			
			let rightBarItem = UIBarButtonItem(customView: filterNavItem)
			self.navigationItem.rightBarButtonItem = rightBarItem
		}
    }
}

extension EUKCalendarTabViewController: EUKSegmentedViewDelegate {
	func selectedIndex(index: Int) {
		self.showViewController(index: index)
	}
}
