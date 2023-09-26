//
//  EUKEmotionsViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/14/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKEmotionsViewController: EUKBaseLogSectionViewController {
    var emotion: [Emotions] {
        get {
            var emotionsArray = [Emotions]()
            for emotionInt in self.selectedIndexes() {
                if let emotion = Emotions(rawValue: emotionInt) {
                    emotionsArray.append(emotion)
                }
            }
            return emotionsArray
        }
        set {
            self.selectButtons(indexes: newValue.map({$0.rawValue}))
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.borderColor = UIColor.eukEmotions
        self.multiSelection = true
        super.viewDidLoad()
    }
}
