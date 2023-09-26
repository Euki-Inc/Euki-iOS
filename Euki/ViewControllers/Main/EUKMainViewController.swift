//
//  EUKMainViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/23/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import MaterialShowcase

class EUKMainViewController: UIViewController {
	static let ShowHomeNotification = "ShowHomeNotification"
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet var navBarContainers: [UIView]!
	@IBOutlet var navBarIcons: [UIImageView]!
	@IBOutlet var navBarLabels: [UILabel]!
	@IBOutlet var navBarBackgrounds: [UIView]!
	@IBOutlet var navBarButtons: [UIButton]!
	
	var selectedItem = 0
    var imageNames = ["IconNavCycle", "IconNavCalendar", "IconNavTrack", "IconNavInfo", "IconNavPrivacy"]
	var viewControllers = [UIViewController]()
	
	//MARK: - IBActions
	
	@IBAction func buttonAction(button: UIButton) {
		let index = button.tag
		self.showIndex(index)
	}

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setUIElements()
		self.initViewControllers()
		self.showIndex(0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(EUKMainViewController.showHome), name: NSNotification.Name(rawValue: EUKMainViewController.ShowHomeNotification), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if LocalDataManager.sharedInstance.shouldShowTabbarTutorial() {
            self.showTutorial(index: 0)
        } else if LocalDataManager.sharedInstance.shouldShowPinUpdate(){
            self.showPinCodeUpdate()
        }

        LocalDataManager.sharedInstance.saveShouldShowPinUpdate(value: false)
    }
    
    //MARK: - Private
	
	private func setUIElements() {
		self.navBarButtons.forEach { button in
			button.addTarget(self, action: #selector(EUKMainViewController.buttonAction(button:)), for: .touchUpInside)
		}
	}
    
	private func initViewControllers() {
        var viewControllers = [UIViewController]()
		
		let cycleViewController = EUKCycleTabViewController.initViewController()
		viewControllers.append(cycleViewController)
        
        if let calendarViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateInitialViewController() {
            calendarViewController.tabBarItem = UITabBarItem(title: "calendar".localized, image: #imageLiteral(resourceName: "IconTabbarCalendarOff"), selectedImage: #imageLiteral(resourceName: "IconTabbarCalendarOn"))
            let navCalendarViewController = UINavigationController(rootViewController: calendarViewController)
            navCalendarViewController.view.backgroundColor = UIColor.eukNavBackground
            viewControllers.append(navCalendarViewController)
        }
        
        let dailyLogViewController = UIViewController()
        dailyLogViewController.tabBarItem = UITabBarItem(title: "daily_log".localized, image: #imageLiteral(resourceName: "IconTabbarDailyLogOff"), selectedImage: #imageLiteral(resourceName: "IconTabbarDailyLogOn"))
        let navDailyLogViewController = UINavigationController(rootViewController: dailyLogViewController)
        navDailyLogViewController.view.backgroundColor = UIColor.eukNavBackground
        viewControllers.append(navDailyLogViewController)
		
		if let homeViewController = EUKHomeViewController.initViewController() {
			homeViewController.tabBarItem = UITabBarItem(title: "home".localized, image: #imageLiteral(resourceName: "IconTabbarHomeOff"), selectedImage: #imageLiteral(resourceName: "IconTabbarHomeOn"))
			let navViewController = UINavigationController(rootViewController: homeViewController)
			navViewController.view.backgroundColor = UIColor.eukNavBackground
			navViewController.navigationBar.isTranslucent = false
			viewControllers.append(navViewController)
		}

        if let settingsViewController = UIStoryboard(name: "Settings", bundle: Bundle.main).instantiateInitialViewController() {
            settingsViewController.tabBarItem = UITabBarItem(title: "privacy".localized, image: #imageLiteral(resourceName: "IconTabbarPrivacyOff"), selectedImage: #imageLiteral(resourceName: "IconTabbarPrivacyOn"))
            let navPrivacyViewController = UINavigationController(rootViewController: settingsViewController)
            navPrivacyViewController.view.backgroundColor = UIColor.eukNavBackground
            viewControllers.append(navPrivacyViewController)
        }
        
        self.viewControllers = viewControllers
    }
    
    @objc func showHome() {
		self.showIndex(0)
    }
    
    func showTutorial(index: Int) {
		guard let view = self.navBarContainers.first(where: { $0.tag == index }) else {
			return
		}
		
        let title = String(format: "tabbar_tutorial_title_%d".localized, index).localized
        let content = String(format: "tabbar_tutorial_content_%d".localized, index).localized
        
        let showcase = self.createTutorial(title: title, content: content)
        showcase.tag = index
		
		view.tintColor = UIColor.eukLightMint
		showcase.setTargetView(view: view)
        showcase.delegate = self
        showcase.show(completion: nil)
    }
    
    func showPinCodeUpdate() {
        let fakeCode = (LocalDataManager.sharedInstance.pinCode() ?? "") == "1111" ? "2222" : "1111"
        let message = String(format: "pin_code_update_alert_message".localized, fakeCode)
        let alertController = self.alertViewController(title: "pin_code_update_alert_title".localized, message: message, okHandler: nil)
        self.present(alertController, animated: true)
    }
	
	func showIndex(_ index: Int) {
		if index == 2 {
			self.showTrack()
			return
		}
		
		self.viewControllers.forEach({ $0.removeFromParent() })
		
		for i in 0 ... 4 {
			let isSelected = i == index
			let normalSuffix = isSelected ? "On" : "Off"
			let imageName = "\(self.imageNames[i])\(normalSuffix)"
			
			self.navBarIcons.first(where: { $0.tag ==  i})?.image = UIImage(named: imageName)
			self.navBarLabels.first(where: { $0.tag ==  i})?.font = UIFont.systemFont(ofSize: 10.0, weight: isSelected ? .bold : .regular)
			self.navBarBackgrounds.first(where: { $0.tag ==  i})?.isHidden = !isSelected
		}
		
		let viewController = self.viewControllers[index]
		self.configureChildViewController(childController: viewController, onView: self.containerView)
	}
	
	private func showTrack() {
		CalendarManager.sharedInstance.todayCalendarItem { [unowned self] (calendarItem) in
			if let logViewController = EUKTrackViewController.initViewController(date: Date(), calendarItem: calendarItem) {
				logViewController.modalPresentationStyle = .fullScreen
				self.present(logViewController, animated: true, completion: nil)
			}
		}
	}
	
	//Public
	
	class func initViewController() -> UIViewController? {
		return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
	}
}

extension EUKMainViewController: MaterialShowcaseDelegate {
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
		if showcase.tag == self.viewControllers.count - 1 {
			((self.viewControllers.first as? UINavigationController)?.viewControllers.first as? EUKCycleTabViewController)?.showTutorial()
		} else {
			let nextTag = showcase.tag + 1
			self.showTutorial(index: nextTag)
		}
    }
}
