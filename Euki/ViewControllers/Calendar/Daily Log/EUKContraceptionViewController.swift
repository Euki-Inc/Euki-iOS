//
//  EUKContraceptionViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/15/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKContraceptionViewControllerDelegate: AnyObject {
    func sectionChanged()
}

class EUKContraceptionViewController: EUKBaseLogSectionViewController {
    @IBOutlet var dailyMethodsButton: UIButton!
    @IBOutlet var longTermMethodsButton: UIButton!
    @IBOutlet var dailyMethodsStackView: UIStackView!
    @IBOutlet var longTermMethodsStackView: UIStackView!
    @IBOutlet var pillButtons: [EUKSelectButton]!
    @IBOutlet var otherDailyButtons: [EUKSelectButton]!
    @IBOutlet var iudButtons: [EUKSelectButton]!
    @IBOutlet var implantButtons: [EUKSelectButton]!
    @IBOutlet var patchButtons: [EUKSelectButton]!
    @IBOutlet var ringButtons: [EUKSelectButton]!
    @IBOutlet var otherLongTermButtons: [EUKSelectButton]!
    @IBOutlet var shotButtons: [EUKSelectButton]!
    weak var delegate: EUKContraceptionViewControllerDelegate?
    var indexSelected: Int?
    
    var contraceptionPill: ContraceptionPills? {
        get {
            if let index = self.selectedIndex(buttons: self.pillButtons) {
                return ContraceptionPills(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.pillButtons)
        }
    }
    
    var contraceptionDailyOthers: [ContraceptionDailyOther] {
        get {
            var contraceptionDailyOthersArray = [ContraceptionDailyOther]()
            for contraceptionDailyOtherInt in self.selectedIndexes(buttons: self.otherDailyButtons) {
                if let contraceptionDailyOther = ContraceptionDailyOther(rawValue: contraceptionDailyOtherInt) {
                    contraceptionDailyOthersArray.append(contraceptionDailyOther)
                }
            }
            return contraceptionDailyOthersArray
        }
        set {
            self.selectButtons(indexes: newValue.map({$0.rawValue}), buttons: self.otherDailyButtons)
        }
    }
    
    var contraceptionIUD: ContraceptionIUD? {
        get {
            if let index = self.selectedIndex(buttons: self.iudButtons) {
                return ContraceptionIUD(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.iudButtons)
        }
    }
    
    var contraceptionImplant: ContraceptionImplant? {
        get {
            if let index = self.selectedIndex(buttons: self.implantButtons) {
                return ContraceptionImplant(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.implantButtons)
        }
    }
    
    var contraceptionPatch: ContraceptionPatch? {
        get {
            if let index = self.selectedIndex(buttons: self.patchButtons) {
                return ContraceptionPatch(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.patchButtons)
        }
    }
    
    var contraceptionShot: ContraceptionShot? {
        get {
            if let index = self.selectedIndex(buttons: self.shotButtons) {
                return ContraceptionShot(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.shotButtons)
        }
    }
    
    var contraceptionRing: ContraceptionRing? {
        get {
            if let index = self.selectedIndex(buttons: self.ringButtons) {
                return ContraceptionRing(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue, buttons: self.ringButtons)
        }
    }
    
    var contraceptionLongTermOthers: [ContraceptionLongTermOther] {
        get {
            var contraceptionLongTermOthersArray = [ContraceptionLongTermOther]()
            for contraceptionLongTermOtherInt in self.selectedIndexes(buttons: self.otherLongTermButtons) {
                if let contraceptionLongTermOther = ContraceptionLongTermOther(rawValue: contraceptionLongTermOtherInt) {
                    contraceptionLongTermOthersArray.append(contraceptionLongTermOther)
                }
            }
            return contraceptionLongTermOthersArray
        }
        set {
            self.selectButtons(indexes: newValue.map({$0.rawValue}), buttons: self.otherLongTermButtons)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.borderColor = UIColor.eukContraception
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    
    @IBAction func sectionAction(_ button: UIButton) {
        if button == self.dailyMethodsButton {
            if let indexSelected = self.indexSelected {
                if indexSelected == 0 {
                    self.indexSelected = nil
                    self.dailyMethodsStackView.isHidden = true
                    self.delegate?.sectionChanged()
                    return
                }
            }
            self.indexSelected = 0
            self.dailyMethodsStackView.isHidden = false
            self.longTermMethodsStackView.isHidden = true
        } else {
            if let indexSelected = self.indexSelected {
                if indexSelected == 1 {
                    self.indexSelected = nil
                    self.longTermMethodsStackView.isHidden = true
                    self.delegate?.sectionChanged()
                    return
                }
            }
            self.indexSelected = 1
            self.dailyMethodsStackView.isHidden = true
            self.longTermMethodsStackView.isHidden = false
        }
        self.delegate?.sectionChanged()
    }
    
    
    //MARK: - Private
    
    override func setUIElements() {
        super.setUIElements()
        
        self.pillButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.otherDailyButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.iudButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.implantButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.patchButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.ringButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.otherLongTermButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        self.shotButtons.forEach { (button) in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
        
        self.dailyMethodsButton.addBorders(edges: .top, color: UIColor.eukiMain, thickness: 0.5)
        self.longTermMethodsButton.addBorders(edges: .top, color: UIColor.eukiMain, thickness: 0.5)
     
    }
    
    override func selectedChanged(button: EUKSelectButton) {
        if self.pillButtons.contains(button), button.isSelected {
            for sizeButton in self.pillButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        if self.iudButtons.contains(button), button.isSelected {
            for sizeButton in self.iudButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        if self.implantButtons.contains(button), button.isSelected {
            for sizeButton in self.implantButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        if self.patchButtons.contains(button), button.isSelected {
            for sizeButton in self.patchButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        if self.ringButtons.contains(button), button.isSelected {
            for sizeButton in self.ringButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        if self.patchButtons.contains(button), button.isSelected {
            for sizeButton in self.patchButtons {
                if sizeButton != button {
                    sizeButton.isSelected = false
                }
            }
        }
        
        self.sectionDelegate?.selectionUpdated()
    }
    
    override func hasData() -> Bool {
		return self.contraceptionIUD != nil || self.contraceptionImplant != nil || self.contraceptionPill != nil || self.contraceptionRing != nil || self.contraceptionPatch != nil || self.contraceptionDailyOthers.count > 0 || self.contraceptionLongTermOthers.count > 0 || self.contraceptionShot != nil
    }
}
