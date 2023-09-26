//
//  EUKTermsOfUseViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 1/21/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class EUKTermsOfUseViewController: EUKBaseOnboardingViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - IBActions
    
    @IBAction override func next() {
        LocalDataManager.sharedInstance.saveOnboardingScreens(show: false)
        super.next()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        let alertController = self.alertViewController(title: nil, message: "terms_of_use_accept".localized, okHandler: nil)
        self.present(alertController, animated: true, completion: nil)
    }
}
