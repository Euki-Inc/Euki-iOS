//
//  EUKCodeConfirmationViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/5/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCodeConfirmationViewController: EUKBaseOnboardingViewController {
    @IBOutlet weak var messageLabel: EUKLabel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = LocalDataManager.sharedInstance.pinCode() {
            self.messageLabel.localizedKey = "pin_code_message"
        } else {
            self.messageLabel.localizedKey = "no_pin_code_message"
        }
    }

}
