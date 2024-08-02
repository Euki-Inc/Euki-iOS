//
//  Question.swift
//  Euki
//
//  Created by Víctor Chávez on 7/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class Question: NSObject {
    var title: String
    var options: [(String, [Int])]
    var answerIndex: Int?
    
    init(title: String) {
        self.title = title
        self.options = [(String, [Int])]()
    }
}
