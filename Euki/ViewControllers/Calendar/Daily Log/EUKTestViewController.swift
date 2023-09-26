//
//  EUKTestViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/15/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKTestViewController: EUKBaseLogSectionViewController {
    @IBOutlet var testSTIButtons: [EUKSelectButton]!
    @IBOutlet var testPregancyButtons: [EUKSelectButton]!
    
    var testSTI: TestSTI? {
        get {
            if let index = self.selectedIndex(buttons: self.testSTIButtons) {
                return TestSTI(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.testSTIButtons)
        }
    }
    
    var testPregnancy: TestPregnancy? {
        get {
            if let index = self.selectedIndex(buttons: self.testPregancyButtons) {
                return TestPregnancy(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.testPregancyButtons)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.borderColor = UIColor.eukTest
        super.viewDidLoad()
    }
    
    //MARK: - Private
    
    override func setUIElements() {
        super.setUIElements()
        
        self.testSTIButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.testPregancyButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
    }
    
    override func selectedChanged(button: EUKSelectButton) {
        super.selectedChanged(button: button)
        
        if testSTIButtons.contains(button), button.isSelected {
            for sizeButton in self.testSTIButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        if testPregancyButtons.contains(button), button.isSelected {
            for sizeButton in self.testPregancyButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        self.sectionDelegate?.selectionUpdated()
    }
    
    override func hasData() -> Bool {
        return self.testSTI != nil || self.testPregnancy != nil
    }
}
