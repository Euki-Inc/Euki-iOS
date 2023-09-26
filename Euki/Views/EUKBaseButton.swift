//
//  EUKBaseButton.swift
//  Euki
//
//  Created by Víctor Chávez on 3/20/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBaseButton: UIButton {
    
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
            self.setAttributedTitle(nil, for: .normal)
            let localizedString = self.allCaps ? self.localizedKey.localized.uppercased() : self.localizedKey.localized
            self.setTitle(localizedString, for: .normal)
        }
    }
}

