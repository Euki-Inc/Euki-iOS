//
//  EUKCycleDayCollectionViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 10/6/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKCycleDayCollectionViewCell: UICollectionViewCell {
	static let CellIdentifier = "EUKCycleDayCollectionViewCell"

	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var cycleDayLabel: UILabel!
	@IBOutlet weak var nextCycleView: UIView!
	@IBOutlet weak var nextCycleDateLabel: UILabel!
	@IBOutlet weak var dataView: UIView!
	
	func setup(date: Date, isBleeding: Bool, dayCycle: Int?, dateNextCycle: Date?) {
		let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.EEEMMMdd)
        self.dateLabel.text = dateString?.capitalized
		
		if let dayCycle = dayCycle {
			self.cycleDayLabel.text = String(format: "cycle_day_format".localized, dayCycle)
			self.cycleDayLabel.isHidden = false
		} else {
			self.cycleDayLabel.isHidden = true
		}
		
		if let dateNextCycle = dateNextCycle {
			let dateString = DateManager.sharedInstance.string(date: dateNextCycle, format: DateManager.sharedInstance.MMMdd)?.capitalized
			self.nextCycleDateLabel.text = dateString
			self.nextCycleView.isHidden = false
		} else {
			self.nextCycleView.isHidden = true
		}

		self.layer.cornerRadius = 100
		self.layer.borderWidth = 6
		self.layer.borderColor = (isBleeding ? UIColor.eukBleeding : UIColor.eukiAccent).cgColor
	}
}
