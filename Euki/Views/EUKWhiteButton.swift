//
//  EUKWhiteButton.swift
//  Euki
//
//  Created by Víctor Chávez on 4/10/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

@IBDesignable
class EUKWhiteButton: EUKBorderedButton {
    
    override func setUIElements(){
        super.setUIElements()
        self.buttonColor = UIColor.white
        self.selectedButtonColor = UIColor.eukPurpleClear
        self.borderColor = UIColor.eukiMain
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        self.setTitleColor(UIColor.eukiMain, for: .normal)
        self.setTitleColor(UIColor.eukiAccent, for: .highlighted)
    }
    
}
