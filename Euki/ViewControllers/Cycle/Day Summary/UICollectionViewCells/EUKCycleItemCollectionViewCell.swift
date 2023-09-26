//
//  EUKCycleItemCollectionViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 10/6/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKCycleItemCollectionViewCell: UICollectionViewCell {
	static let CellIdentifier = "EUKCycleItemCollectionViewCell"

	@IBOutlet weak var selectButton: EUKSelectButton!
	@IBOutlet weak var centerConstraint: NSLayoutConstraint!
}
