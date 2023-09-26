//
//  EUKFakeCodeViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 4/11/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKFakeCodeViewController: EUKBaseOnboardingViewController {
    let CodeUnitNumberTags = 100
    let CodeUnitLineTags = 200

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDots()
    }
    
    //MARK: - Private
    
    func showDots() {
        let code = (LocalDataManager.sharedInstance.pinCode() ?? "") == "1111" ? "2222" : "1111"
        
        let codeSize = code.count
        
        for index in 0 ... 3 {
            if let lineView = self.view.viewWithTag(self.CodeUnitLineTags + index) {
                lineView.backgroundColor = codeSize > 0 ? UIColor.eukiAccent : UIColor.eukiMain
            }
            if let digitLabel = self.view.viewWithTag(self.CodeUnitNumberTags + index) as? UILabel {
                digitLabel.text = code.count > index ? code[index] : ""
            }
        }
    }
    
}
