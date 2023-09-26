//
//  EUKAutoTopLevelViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/29/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKAutoTopLevelViewController: EUKCommonTopLevelViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Public

    class func initViewController() -> EUKAutoTopLevelViewController? {
        if let viewController = super.initViewController(anyClass: EUKAutoTopLevelViewController.self) as? EUKAutoTopLevelViewController {
            return viewController
        }
        return nil
    }
    
}
