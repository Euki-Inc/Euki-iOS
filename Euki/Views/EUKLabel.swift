//
//  EUKLabel.swift
//  Euki
//
//  Created by Víctor Chávez on 11/26/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKLabel: UILabel {
    
    @IBInspectable var localizedKey:String = "" {
        didSet {
            self.setLocalizedString()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var allCaps:Bool = false {
        didSet {
            self.setLocalizedString()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var enableLineSpacing:Bool = false {
        didSet {
            self.setLocalizedString()
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
    
    //MARK: - Private
    
    func setUIElements(){
        self.setLocalizedString()
    }
    
    func setLocalizedString(){
        if !self.localizedKey.isEmpty{
            let text: String
            if self.allCaps {
                text = self.localizedKey.localized.uppercased()
            } else {
                text = self.localizedKey.localized
            }
            
            self.text = nil
            self.attributedText = nil

            if self.enableLineSpacing {
                let attributes = [
                    NSAttributedStringKey.font: self.font as Any,
                    NSAttributedStringKey.foregroundColor: self.textColor as Any,
                    NSAttributedStringKey.paragraphStyle: UIFont.paragraphStyle()
                ]
                self.attributedText = NSAttributedString(string: text, attributes: attributes)
            } else {
                self.text = text
            }
        }
    }
}
