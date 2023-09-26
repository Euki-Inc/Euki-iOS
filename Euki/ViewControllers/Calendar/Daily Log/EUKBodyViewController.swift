//
//  EUKBodyViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/15/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBodyViewController: EUKBaseLogSectionViewController {
    var body: [Body] {
        get {
            var bodyArray = [Body]()
            for bodyInt in self.selectedIndexes() {
                if let body = Body(rawValue: bodyInt) {
                    bodyArray.append(body)
                }
            }
            return bodyArray
        }
        set {
            self.selectButtons(indexes: newValue.map({$0.rawValue}))
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.borderColor = UIColor.eukBody
        self.multiSelection = true
        super.viewDidLoad()
    }
}
