//
//  EUKNavItemView.swift
//  Euki
//
//  Created by Víctor Chávez on 29/5/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKNavItemView: UIView {
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var blurView: UIView!
	
	class func initView() -> EUKNavItemView? {
		let nib = UINib(nibName: "EUKNavItemView", bundle: Bundle.main)
		return nib.instantiate(withOwner: nil, options: nil).first as? EUKNavItemView
	}
}
