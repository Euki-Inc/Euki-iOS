//
//  EUKSegmentedView.swift
//  Euki
//
//  Created by Víctor Chávez on 29/5/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

@objc protocol EUKSegmentedViewDelegate {
	func selectedIndex(index: Int)
}

@IBDesignable
class EUKSegmentedView: CommonNibView {
	@IBInspectable var leftButtonlocalizedKey: String = "" {
		didSet {
			self.buttons.first(where: { $0.tag == 0 })?.setTitle(leftButtonlocalizedKey.localized.uppercased(), for: UIControlState.normal)
		}
	}
	
	@IBInspectable var rightButtonlocalizedKey: String = "" {
		didSet {
			self.buttons.first(where: { $0.tag == 1 })?.setTitle(rightButtonlocalizedKey.localized.uppercased(), for: UIControlState.normal)
		}
	}
	
	@IBOutlet var delegate: EUKSegmentedViewDelegate?
	
	@IBOutlet var buttons: [UIButton]!
	@IBOutlet var blurViews: [UIView]!
	@IBOutlet var indicatorViews: [UIView]!
	
	private var currentIndex: Int = -1
	
	//MARK: - IBActions
	
	@IBAction func tapped(_ sender: UIButton) {
		self.changeItem(index: sender.tag)
	}
	
	//MARK: - Public
	
	func changeItem(index: Int) {
		if self.currentIndex == index {
			return
		}
		
		self.currentIndex = index
		
		self.blurViews.forEach { view in
			view.isHidden = view.tag != index
		}
		
		self.indicatorViews.forEach { view in
			let color = view.tag != index ? UIColor.eukPrimaryLighter : UIColor.eukiAccent
			view.backgroundColor = color
		}
		
		self.delegate?.selectedIndex(index: index)
	}
	
	//MARK: - Private
	
	override func nibSetup() {
		super.nibSetup()
		self.setUIElements()
	}
	
	private func setUIElements() {
		self.buttons.forEach { button in
			button.addTarget(self, action: #selector(EUKSegmentedView.tapped(_:)), for: .touchUpInside)
		}
		
		self.changeItem(index: 0)
	}
}
