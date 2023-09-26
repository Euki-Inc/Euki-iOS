//
//  EUKSelectButton.swift
//  Euki
//
//  Created by Víctor Chávez on 6/13/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKSelectButtonDelegate: AnyObject {
    func selectedChanged(button: EUKSelectButton)
}

@IBDesignable
class EUKSelectButton: CommonNibView {
    @IBInspectable var singleSelection: Bool = true
    
    @IBInspectable var isSelected: Bool = false {
        didSet {
            self.borderContainerView.layer.borderColor = (isSelected ? self.borderColor : UIColor.clear).cgColor
            self.borderContainerView.layer.borderWidth = 6.0
            self.delegate?.selectedChanged(button: self)
        }
    }
    
    @IBInspectable var localizedKey: String = "" {
        didSet {
            self.titleLabel.text = localizedKey.localized
        }
    }
    
    @IBInspectable var image: UIImage? {
        didSet {
            self.button.setImage(image, for: .normal)
        }
    }
    
    @IBInspectable var smallFont: Bool = false {
        didSet {
            if self.smallFont {
                self.titleLabel.font = UIFont.systemFont(ofSize: 13.0)
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var borderContainerView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countContainerView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    var count = 0 {
        didSet {
            self.updateCounter()
        }
    }
    
    weak var delegate: EUKSelectButtonDelegate?
    
    //MARK: - IBActions
    
    @IBAction func tapped(_ sender: Any) {
        if self.singleSelection {
            self.isSelected = !self.isSelected
        } else {
            if !self.isSelected {
                self.isSelected = true
            }
            
            if self.count < 10 {
                self.count += 1
            }
            self.updateCounter()
        }
    }
    
    @IBAction func longPress(_ sender: UIGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.ended {
            return
        }
        
        if self.singleSelection {
            return
        }
        
        if !self.isSelected {
            return
        }
        
        self.count = 0
        self.updateCounter()
        self.isSelected = false
    }
    
    //MARK: - Private
    
    override func nibSetup() {
        super.nibSetup()
        self.setUIElements()
    }
    
    func setUIElements() {
        self.button.setImage(self.image, for: .normal)
        self.titleLabel.text = localizedKey.localized
        self.titleLabel.textColor = UIColor.eukiAccent
        self.countContainerView.isHidden = self.singleSelection || (!self.singleSelection && self.count == 0)
        self.countLabel.text = "\(self.count)"
    }
    
    func updateCounter() {
        self.isSelected = count > 0
        self.countContainerView.isHidden = self.singleSelection || (!self.singleSelection && self.count == 0)
        self.countLabel.text = "\(self.count)"
    }
}
