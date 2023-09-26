//
//  EUKCheckCodeViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/16/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCheckCodeViewController: EUKCodeViewController {
    @IBOutlet weak var fakeView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var shouldShowMainViewController = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fakeView.isHidden = true
        self.errorLabel.isHidden = true
    }
    
    //MARK: - IBActions
    
    override func next() {
		if !self.fakeView.isHidden {
			exit(0)
		}
		
        let fakeCode = (LocalDataManager.sharedInstance.pinCode() ?? "") == "1111" ? "2222" : "1111"
        
        if let pinCode = LocalDataManager.sharedInstance.pinCode(), pinCode == self.code {
            if self.shouldShowMainViewController {
                (UIApplication.shared.delegate as! AppDelegate).showMainViewController()
            } else {
                self.performSegue(withIdentifier: self.DoneSegueIdentifier, sender: nil)
            }
        } else if self.code == fakeCode {
            self.fakeView.isHidden = false
            self.code = ""
            self.showDots()
        } else {
            self.errorLabel.isHidden = false
            self.code = ""
            self.showDots()
        }
    }
    
    //MARK: - Private
    
    override func showDots() {
        super.showDots()
        self.bottomButton.isEnabled = self.code.count == 4
		self.bottomButton.setTitle("go".localized.uppercased(), for: .normal)
        
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
    
    override func backgroundAction() {
        self.fakeView.isHidden = true
    }
}
