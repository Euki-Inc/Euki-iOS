//
//  EUKBasePinCheckViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/16/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBasePinCheckViewController: EUKBaseBackgroundCheckViewController {
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Notifications
    
    override func backgroundAction() {
        if LocalDataManager.sharedInstance.pinCode() == nil {
            return
        }
        
        if let _ = self.presentingViewController as? EUKCheckCodeViewController {
            return
        }
        
        let viewController = UIStoryboard(name: "Onboardings", bundle: Bundle.main).instantiateViewController(withIdentifier: "EnterPinCode")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion: nil)
    }

}
