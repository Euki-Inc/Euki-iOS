//
//  EUKRoundedView.swift
//  Euki
//
//  Created by Víctor Chávez on 3/20/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

@IBDesignable
class EUKBorderedButton: EUKBaseButton {
    
    @IBInspectable var buttonColor:UIColor = UIColor.white {
        didSet {
            self.setButtonColors()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var selectedButtonColor:UIColor = UIColor.clear {
        didSet {
            self.setButtonColors()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.clear {
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
    
    @IBInspectable var textColor:UIColor = UIColor.eukGunmetal {
        didSet {
            self.setTextColor()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius:Int = 10 {
        didSet {
            self.setCornerRadius()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var rounded:Bool = true {
        didSet {
            self.setCornerRadius()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var defaultFont:Bool = false {
        didSet {
            self.setUIElements()
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
    
    override func setUIElements(){
        super.setUIElements()
        self.backgroundColor = UIColor.clear
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        self.titleLabel?.textAlignment = .center
        
        if self.defaultFont {
            self.titleLabel?.font = UIFont.eukButtonFont()
        }
        
        self.setButtonColors()
        self.setBorderColors()
        self.setTextColor()
    }
    
    func setButtonColors(){
        var lightColor: UIColor
        
        if self.selectedButtonColor == UIColor.clear {
            if self.buttonColor == UIColor.clear{
                lightColor = UIColor.lightGray
            } else{
                lightColor = self.buttonColor.withAlphaComponent(0.8)
            }
        } else {
            lightColor = self.selectedButtonColor
        }
        
        self.setBackgroundImage(UIImage(color: self.buttonColor), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(color: lightColor), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(color: lightColor), for: UIControlState.focused)
    }
    
    func setBorderColors(){
        let lightColor = self.borderColor.withAlphaComponent(0.8)
        self.layer.borderColor = lightColor.cgColor
        self.layer.borderWidth = self.borderWidth
    }
    
    func setBorderWidth(){
        self.layer.borderWidth = self.borderWidth
    }
    
    func setTextColor(){
        let lightColor = self.textColor.withAlphaComponent(0.8)
        self.setTitleColor(self.textColor, for: UIControlState.normal)
        self.setTitleColor(lightColor, for: UIControlState.highlighted)
        self.setTitleColor(lightColor, for: UIControlState.focused)
    }
    
    func setCornerRadius(){
        var cornerRadius: CGFloat
        if self.rounded{
            cornerRadius = self.bounds.size.height / 2.0
        } else{
            cornerRadius = CGFloat(self.cornerRadius)
        }
        self.layer.cornerRadius = cornerRadius
    }
}
