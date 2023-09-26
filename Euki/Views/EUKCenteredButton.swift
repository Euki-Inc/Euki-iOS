//
//  EUKCenteredButton.swift
//  Euki
//
//  Created by Víctor Chávez on 28/5/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

@IBDesignable
class EUKCenteredButton: EUKBaseButton {
	
	@IBInspectable var titlePadding:Int = 0
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.imageView?.contentMode = .scaleAspectFit
		
		if let imageView = self.imageView {
			imageView.frame.origin.x = (self.bounds.size.width - imageView.frame.size.width) / 2.0
			imageView.frame.origin.y = -3.0
		}
		if let titleLabel = self.titleLabel {
			titleLabel.frame.origin.x = (self.bounds.size.width - titleLabel.frame.size.width) / 2.0
			titleLabel.frame.origin.y = self.bounds.size.height - titleLabel.frame.size.height + CGFloat(titlePadding)
		}
	}
}
