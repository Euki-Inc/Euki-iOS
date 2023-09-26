//
//  EUKRoundedView.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

@IBDesignable
class EUKRoundedView: UIView {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUIElements()
    }
    
    //MARK: - Private
    
    func setUIElements(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}
