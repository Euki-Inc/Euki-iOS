//
//  EUKCycleEmptyCollectionViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 10/6/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKCycleEmptyCollectionViewCell: UICollectionViewCell {
	static let CellIdentifier = "EUKCycleEmptyCollectionViewCell"

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var trackButton: UIButton!
	@IBOutlet weak var spacingHeight: NSLayoutConstraint!
}
