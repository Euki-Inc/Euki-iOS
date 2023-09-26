//
//  EUKCycleSumaryDayTableViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 6/1/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class EUKCycleSumaryDayTableViewCell: MGSwipeTableCell {
	static let CellIdentifier = "EUKCycleSumaryDayTableViewCell"
	
	@IBOutlet weak var rangeLabel: UILabel!
	@IBOutlet weak var bleedingLabel: UILabel!
	@IBOutlet weak var currentDayIndicatorView: EUKBorderedView!
	@IBOutlet weak var slidersView: UIView!
	
	@IBOutlet weak var periodSizeTrailingConstraint: NSLayoutConstraint!
	@IBOutlet weak var bleedingSizeTrailingConstraint: NSLayoutConstraint!
	@IBOutlet weak var dayIndicatorLeadingConstraint: NSLayoutConstraint!
}
