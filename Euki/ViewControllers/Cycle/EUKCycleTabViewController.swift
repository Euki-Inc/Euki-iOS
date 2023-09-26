//
//  EUKCycleTabViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/1/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKCycleTabViewController: EUKBasePinCheckViewController {
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var tutorialView: UIView!
	
	var viewControllers = [UIViewController]()
	var currentViewController: UIViewController?

	//MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.initViewControllers()
		self.setUIElements()
		self.showViewController(index: 0)
	}
	
	//MARK: - IBActions
	
	@IBAction func showSettings() {
		if let viewController = EUKCycleSettingsViewController.initViewController() {
			viewController.modalPresentationStyle = .fullScreen
			self.present(viewController, animated: true)
		}
	}
	
	@IBAction func hideTutorialView(_ sender: Any) {
		self.tutorialView.isHidden = true
	}
	
	//MARK: - Public
	
	func showTutorial() {
		guard let barButtonItem = self.navigationItem.rightBarButtonItem else {
			return
		}
		
		let title = "cycle_settings_tutorial_title".localized
		let content = "cycle_settings_tutorial_content".localized
		
		let showcase = self.createTutorial(title: title, content: content)
		showcase.tag = index
		showcase.setTargetView(barButtonItem: barButtonItem, tapThrough: false)
		showcase.show(completion: nil)
	}
	
	class func initViewController() -> UIViewController {
		return UIStoryboard(name: "Cycle", bundle: nil).instantiateInitialViewController() ?? UIViewController()
	}
	
	//MARK: - Private
	
	private func initViewControllers() {
		if let viewController = EUKDaySummaryViewController.initViewController() {
			self.viewControllers.append(viewController)
		}
		if let viewController = EUKCycleSummaryViewController.initViewController() {
			self.viewControllers.append(viewController)
		}
	}
	
	private func setUIElements() {
		self.title = "nav_cycle".localized
		let item = UIBarButtonItem(title: "settings_nav_item".localized.uppercased(), style: .plain, target: self, action: #selector(EUKCycleTabViewController.showSettings))
		self.navigationItem.rightBarButtonItem = item
		self.tutorialView.isHidden = true
	}
	
	private func validateTutorial() {
		if LocalDataManager.sharedInstance.shouldShowCycleSummaryTutorial() {
			self.tutorialView.isHidden = false
		}
	}
	
	private func showViewController(index: Int) {
		self.currentViewController?.removeFromParent()
		
		let viewController = self.viewControllers[index]
		self.configureChildViewController(childController: viewController, onView: self.containerView)
		self.currentViewController = viewController
		
		if index == 1 {
			self.validateTutorial()
		}
	}
}

extension EUKCycleTabViewController: EUKSegmentedViewDelegate {
	func selectedIndex(index: Int) {
		self.showViewController(index: index)
	}
}
