//
//  EUKNoteViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/15/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKNoteViewController: UIViewController {
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    weak var sectionDelegate: EUKLogSectionDelegate?
    
    var note: String? {
        get {
            return self.noteField.text
        }
        set {
            self.noteField.text = newValue
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    //MARK: - Private
    
    func setUIElements() {
        self.noteField.delegate = self
        self.noteField.addTarget(self, action: #selector(EUKNoteViewController.changeCounters), for: .editingChanged)
    }
    
    @objc func changeCounters() {
        self.countLabel.text = "\(self.noteField.text?.count ?? 0)/200"
    }
    
    func hasData() -> Bool {
        return !(self.noteField.text ?? "").isEmpty
    }
}

extension EUKNoteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let nsString = textField.text as? NSString {
            let newString = nsString.replacingCharacters(in: range, with: string)
            return newString.count <= 200
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.changeCounters()
        self.sectionDelegate?.selectionUpdated()
    }
}
