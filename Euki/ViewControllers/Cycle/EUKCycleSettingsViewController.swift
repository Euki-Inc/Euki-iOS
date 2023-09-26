//
//  EUKDaySummaryViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/1/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKCycleSettingsViewController: EUKBasePinCheckViewController {
	@IBOutlet weak var trackPeriodSwitch: UISwitch!
	@IBOutlet weak var periodPredictionSwitch: UISwitch!
	
	//MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.updateUIElements()
	}
	
	//MARK: - IBActions
	
	@IBAction func switchChanged(sender: UISwitch) {
		if sender == self.trackPeriodSwitch {
			LocalDataManager.sharedInstance.saveTrackPeriodEnabled(value: sender.isOn)
			if !sender.isOn {
				LocalDataManager.sharedInstance.savePeriodPredictionEnabled(value: false)
			}
		} else {
			LocalDataManager.sharedInstance.savePeriodPredictionEnabled(value: sender.isOn)
		}
		
		self.updateUIElements()
	}
	
	@IBAction func backAction() {
		self.presentingViewController?.dismiss(animated: true)
	}

	//MARK: - Public
	
	class func initViewController() -> UIViewController? {
		return UIStoryboard(name: "Cycle", bundle: nil).instantiateViewController(withIdentifier: "EUKCycleSettingsViewController")
	}
	
	//MARK: - Private
	
	func updateUIElements() {
		let trackPeriodEnabled = LocalDataManager.sharedInstance.trackPeriodEnabled()
		let periodPredictionEnabled = LocalDataManager.sharedInstance.periodPredictionEnabled()
		
		self.trackPeriodSwitch.isOn = trackPeriodEnabled
		self.periodPredictionSwitch.isOn = periodPredictionEnabled
		self.periodPredictionSwitch.isEnabled = trackPeriodEnabled
	}
}
