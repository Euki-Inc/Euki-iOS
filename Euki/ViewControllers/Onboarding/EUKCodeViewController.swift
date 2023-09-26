//
//  EUKCodeViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 4/11/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCodeViewController: EUKBaseOnboardingViewController {
    let CodeUnitNumberTags = 100
    let CodeUnitLineTags = 200
    
    @IBOutlet weak var bottomButton: EUKWhiteButton!
    
    var code = ""

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDots()
    }

    //MARK: - IBActions
    
    @IBAction func keyboardAction(_ button: UIButton) {
        if let title = button.title(for: .normal), let _ = Int(title) {
            if code.count == 4 {
                return
            }
            
            code.append(title)
        } else {
            if code.count > 0 {
                code.removeLast()
            }
        }
        self.showDots()
    }
    
    override func next() {
        if self.code.count == 4 {
            LocalDataManager.sharedInstance.savePincode(pinCode: self.code)
            super.next()
        } else {
            self.showTerms()
        }
    }
    
    //MARK: - Private
    
    func showDots() {
        self.bottomButton.setTitle(self.code.count == 4 ? "set_pin".localized.uppercased() : "skip".localized.uppercased(), for: .normal)
        
        let codeSize = self.code.count
        
        for index in 0 ... 3 {
            if let lineView = self.view.viewWithTag(self.CodeUnitLineTags + index) {
                lineView.backgroundColor = codeSize > 0 ? UIColor.eukiAccent : UIColor.eukiAccent
            }
            if let digitLabel = self.view.viewWithTag(self.CodeUnitNumberTags + index) as? UILabel {
                digitLabel.text = self.code.count > index ? self.code[index] : ""
            }
        }
    }
    
}
