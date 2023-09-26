//
//  EUKDayCollectionViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 7/2/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKDayCollectionViewCell: UICollectionViewCell {
    static let CellIdentifier = "EUKDayCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
	@IBOutlet weak var blurView: UIView!
	@IBOutlet weak var bleedingView: UIView!
	@IBOutlet weak var bleedingHeightConstraint: NSLayoutConstraint!
    
    var RoundViewTag = 200
	var BleedingViewHeight = 18
    
	func setup(day: Int, dayName: String? = nil, calendarItem: CalendarItem?, calendarFilter: CalendarFilter = CalendarFilter(), isSelectedDate: Bool, isToday: Bool, isPrediction: Bool = false) {
        self.titleLabel.text = dayName
        self.titleLabel.isHidden = dayName == nil
        
        self.dayLabel.text = "\(day)"
        
        self.actionButton.setBackgroundImage(UIImage(color: UIColor.eukiAccent), for: .highlighted)
        self.actionButton.alpha = 0.5
		
		var borderWidth: CGFloat
		var borderColor: UIColor

		if isSelectedDate {
			borderWidth = 4.0
			borderColor = UIColor.eukiAccent
		} else if isToday {
			borderWidth = 4.0
			borderColor = UIColor.eukPrimaryLighter
		} else {
			borderWidth = 1.0
			borderColor = UIColor.eukiAccent
		}

		if (calendarItem?.hasPeriod() ?? false) && !(isToday && !isSelectedDate) {
			borderColor = UIColor.eukBleeding
		}

		self.dayView.layer.cornerRadius = self.dayView.bounds.width / 2.0
		self.dayView.layer.borderColor = borderColor.cgColor
		self.dayView.layer.borderWidth = borderWidth
		self.dayView.layer.masksToBounds = true
		
		var bleedingHeight = 0.0
		var showBleedingView = calendarItem?.hasPeriod() ?? false
		
		if let size = calendarItem?.bleedingSize {
			switch size {
			case BleedingSize.spoting:
				bleedingHeight = 6
			case BleedingSize.light:
				bleedingHeight = 10
			case BleedingSize.medium:
				bleedingHeight = 14
			case BleedingSize.heavy:
				bleedingHeight = 18
			}
		}
		
		let bleedingViewAlpha = isPrediction ? 0.3 : 1.0
		if isPrediction {
			bleedingHeight = 14
			showBleedingView = true
		}
		
		self.bleedingView.alpha = bleedingViewAlpha
		self.bleedingView.isHidden = !showBleedingView
		self.bleedingHeightConstraint.constant = bleedingHeight
        
        for index in self.RoundViewTag ... self.RoundViewTag + 7 {
            self.viewWithTag(index)?.isHidden = true
        }
        
        var currentIndex = self.RoundViewTag
        
        guard let calendarItem = calendarItem else {
            return
        }
        
        if calendarItem.hasBleeding() && (calendarFilter.bleedingOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukBleeding
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasEmotions() && (calendarFilter.emotionsOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukEmotions
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasBody() && (calendarFilter.bodyOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukBody
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasSexualActivity() && (calendarFilter.sexualActivityOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukSexualActivity
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasContraception() && (calendarFilter.contraceptionOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukContraception
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasTest() && (calendarFilter.testOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukTest
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasAppointment() && (calendarFilter.appointmentOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukAppointment
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
        if calendarItem.hasNote() && (calendarFilter.noteOn || calendarFilter.showAll()) {
            self.viewWithTag(currentIndex)?.backgroundColor = UIColor.eukNote
            self.viewWithTag(currentIndex)?.isHidden = false
            currentIndex += 1
        }
    }

}
