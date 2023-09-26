//
//  EUKBlueButton.swift
//  Euki
//
//  Created by Víctor Chávez on 6/5/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBlueButton: EUKBorderedButton {
    
    override func setUIElements(){
        super.setUIElements()
        self.buttonColor = UIColor.eukiAccent
        self.selectedButtonColor = UIColor.eukPurpleClear
        self.borderColor = UIColor.eukiAccent
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
		self.allCaps = true
		self.cornerRadius = 100
    }
    
}
