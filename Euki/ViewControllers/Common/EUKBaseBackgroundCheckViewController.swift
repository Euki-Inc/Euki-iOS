//
//  EUKBaseBackgroundCheckViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/16/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBaseBackgroundCheckViewController: EUKBaseViewController {
    static let BackToForgroundNotification = "BackToForgroundNotification"

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(EUKBaseBackgroundCheckViewController.backgroundAction), name: NSNotification.Name(rawValue: EUKBaseBackgroundCheckViewController.BackToForgroundNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Notifications
    
    @objc func backgroundAction() {
    }
}
