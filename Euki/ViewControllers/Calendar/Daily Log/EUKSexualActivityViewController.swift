//
//  EUKSexualActivityViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/15/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKSexualActivityViewController: EUKBaseLogSectionViewController {
    @IBOutlet var protectionSTIButtons: [EUKSelectButton]!
    @IBOutlet var protectionPregnancyButtons: [EUKSelectButton]!
    @IBOutlet var protectionOtherButtons: [EUKSelectButton]!
    
    var sexualProtectionSTICount: [Int] {
        get {
            var countsArray = [Int]()
            for index in 0 ... 1 {
                for button in self.protectionSTIButtons {
                    if button.tag - MinButtonTag == index {
                        countsArray.append(button.count)
                    }
                }
            }
            return countsArray
        }
        set {
            for index in 0 ... 1 {
                for button in self.protectionSTIButtons {
                    if button.tag - MinButtonTag == index {
                        button.count = newValue[index]
                    }
                }
            }
        }
    }
    
    var sexualProtectionPregnancyCount: [Int] {
        get {
            var countsArray = [Int]()
            for index in 0 ... 1 {
                for button in self.protectionPregnancyButtons {
                    if button.tag - MinButtonTag == index {
                        countsArray.append(button.count)
                    }
                }
            }
            return countsArray
        }
        set {
            for index in 0 ... 1 {
                for button in self.protectionPregnancyButtons {
                    if button.tag - MinButtonTag == index {
                        button.count = newValue[index]
                    }
                }
            }
        }
    }
    
    var sexualProtectionOtherCount: [Int] {
        get {
            var countsArray = [Int]()
            for index in 0 ... 4 {
                for button in self.protectionOtherButtons {
                    if button.tag - MinButtonTag == index {
                        countsArray.append(button.count)
                    }
                }
            }
            return countsArray
        }
        set {
            for index in 0 ... 4 {
                for button in self.protectionOtherButtons {
                    if button.tag - MinButtonTag == index {
                        button.count = newValue[index]
                    }
                }
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.borderColor = UIColor.eukSexualActivity
        super.viewDidLoad()
    }
    
    //MARK: - Private
    
    override func setUIElements() {
        super.setUIElements()
        
        self.protectionSTIButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.protectionPregnancyButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.protectionOtherButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
    }
    
    override func selectedChanged(button: EUKSelectButton) {
        self.sectionDelegate?.selectionUpdated()
    }
    
    override func hasData() -> Bool {
        for count in self.sexualProtectionSTICount {
            if count > 0 {
                return true
            }
        }
        for count in self.sexualProtectionPregnancyCount {
            if count > 0 {
                return true
            }
        }
        for count in self.sexualProtectionOtherCount {
            if count > 0 {
                return true
            }
        }
        return false
    }
}
