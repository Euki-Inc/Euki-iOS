//
//  EUKTextField.swift
//  Euki
//
//  Created by pAk on 1/11/20.
//  Copyright © 2020 Ibis. All rights reserved.
//

import UIKit

class EUKTextField: UITextField {
    
    @IBInspectable var localizedKey:String = "" {
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
            self.placeholder = self.localizedKey.localized
        }
    }
}
