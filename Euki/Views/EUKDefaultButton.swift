//
//  EUKGreenButton.swift
//  Euki
//
//  Created by Víctor Chávez on 3/25/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKDefaultButton: EUKBaseButton {
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
        size.height = 50
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
        self.titleLabel?.textAlignment = .left
        self.titleLabel?.font = UIFont.eukGreenButtonFont()
        self.titleLabel?.numberOfLines = 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.eukiMain, for: .highlighted)
        self.setBackgroundImage(UIImage(color: UIColor.eukiMain), for: .normal)
        self.setBackgroundImage(UIImage(color: UIColor.lightGray), for: .highlighted)
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 19.5, 0, 19.5)
    }
}
