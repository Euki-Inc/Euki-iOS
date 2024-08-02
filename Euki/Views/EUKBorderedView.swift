//
//  BorderedView.swift
//  JockeyApp
//
//  Created by Víktor Chávez on 7/6/19.
//  Copyright © 2019 Jockey Plaza. All rights reserved.
//

import UIKit

@IBDesignable
class EUKBorderedView: UIView {
	
	@IBInspectable var borderColor:UIColor = UIColor.eukiMain {
		didSet {
			self.setBorderColors()
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var borderWidth:CGFloat = 1 {
		didSet {
			self.setBorderWidth()
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var cornerRadius:Int = 10 {
		didSet {
			self.setCornerRadius()
			setNeedsDisplay()
		}
	}
	
	//MARK: - Lifecycle
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setUIElements()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setUIElements()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		self.setUIElements()
	}
	
	override var intrinsicContentSize: CGSize{
		var size = super.intrinsicContentSize
		size.height = 40
		return size
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.clipsToBounds = true
	}
	
	//MARK: - Private
	
	func setUIElements(){
		self.setBorderColors()
	}
	
	func setBorderColors(){
		let lightColor = self.borderColor.withAlphaComponent(0.8)
		self.layer.borderColor = lightColor.cgColor
		self.layer.borderWidth = self.borderWidth
	}
	
	func setBorderWidth(){
		self.layer.borderWidth = self.borderWidth
	}
	
	func setCornerRadius(){
		self.layer.cornerRadius = CGFloat(self.cornerRadius)
	}
	
}
