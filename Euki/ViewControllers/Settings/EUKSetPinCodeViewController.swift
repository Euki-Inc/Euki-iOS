//
//  EUKSetPinCodeViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 1/20/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class EUKSetPinCodeViewController: EUKCodeViewController {
    enum PinCodeType: Int {
        case create = 100,
        confirm
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var pinCodeType: PinCodeType = .create
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pinCodeType = LocalDataManager.sharedInstance.pinCode() == nil ? .create : .confirm
        self.updateCodeType()
        self.showDots()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.errorLabel.isHidden = true
    }
    
    //MARK: - IBActions
    
    override func next() {
        if self.pinCodeType == .confirm {
            if let pinCode = LocalDataManager.sharedInstance.pinCode(), pinCode == self.code {
                self.errorLabel.isHidden = true
                self.code = ""
                self.pinCodeType = .create
                self.updateCodeType()
            } else {
                self.errorLabel.isHidden = false
                self.code = ""
            }
            self.showDots()
        } else {
			let message = (self.code.count < 4 ? "new_pin_skip" : "new_pin_confirmation").localized
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.dismiss(animated: true, completion: {
					if self.code.count < 4 {
						self.presentingViewController?.dismiss(animated: true)
					} else {
						super.next()
					}
                })
            })
        }
    }
    
    //MARK: - Private
    
    func updateCodeType() {
        let title: String
        switch self.pinCodeType {
        case .create:
            title = LocalDataManager.sharedInstance.pinCode() == nil ? "onboarding_set_pin_title" : "set_new_pin"
        case .confirm:
            title = "confirm_existing_pin"
        }
        self.titleLabel.text = title.localized
        self.titleLabel.textAlignment = title == "onboarding_set_pin_title" ? .left : .center
    }
    
    override func showDots() {
        super.showDots()
        
        if self.pinCodeType == .create && LocalDataManager.sharedInstance.pinCode() != nil {
            self.bottomButton.isEnabled = self.code.count == 4
            self.bottomButton.setTitle("set_new_pin_button".localized.uppercased(), for: .normal)
        }
        
        if self.pinCodeType == .confirm {
            self.bottomButton.isEnabled = self.code.count == 4
            self.bottomButton.setTitle("next".localized.uppercased(), for: .normal)
            
            let codeSize = self.code.count
            for index in 0 ... 3 {
                if let lineView = self.view.viewWithTag(self.CodeUnitLineTags + index) {
                    lineView.backgroundColor = codeSize > 0 ? UIColor.eukiAccent : UIColor.eukiAccent
                }
                if let digitLabel = self.view.viewWithTag(self.CodeUnitNumberTags + index) as? UILabel {
                    digitLabel.text = self.code.count > index ? "*" : ""
                }
            }
        }
    }
}
