//
//  EUKBaseOnboardingViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 4/11/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBaseOnboardingViewController: EUKBaseBackgroundCheckViewController {
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    
    @IBAction func next() {
        if let onboardingViewController = self.parent?.parent as? EUKOnboardingViewController {
            onboardingViewController.showNext()
        } else {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func showTerms() {
        if let onboardingViewController = self.parent?.parent as? EUKOnboardingViewController {
            onboardingViewController.showTerms()
        }
    }
    
}
