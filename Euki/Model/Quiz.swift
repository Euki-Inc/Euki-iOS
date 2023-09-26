//
//  Quiz.swift
//  Euki
//
//  Created by Víctor Chávez on 7/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class Quiz: NSObject {
    var instructions: String
    var questions: [Question]
    
    init(instructions: String) {
        self.instructions = instructions
        self.questions = [Question]()
    }
}
