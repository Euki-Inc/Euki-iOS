//
//  QuizManager.swift
//  Euki
//
//  Created by Víctor Chávez on 7/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class QuizManager: NSObject {
    static let sharedInstance = QuizManager()
    
    func requestContraceptionQuiz(responseHandler: @escaping (Quiz?) -> Void) {
        let quiz = Quiz(instructions: "contraception_quiz_instructions")
        
        var question = Question(title: "how_want_start_method")
        question.options.append(("pn_my_own", [8, 9, 10, 12]))
        question.options.append(("at_a_clinic", [1, 2, 3, 4, 5, 6, 7]))
        question.options.append(("want_permanent_method", [11]))
        quiz.questions.append(question)
        
        question = Question(title: "how_often_use_method")
        question.options.append(("when_i_have_sex", [8, 9, 10, 12]))
        question.options.append(("daily", [6]))
        question.options.append(("weekly", [5]))
        question.options.append(("monthly", [4, 7]))
        question.options.append(("yearly_or_less", [1, 2, 3, 11]))
        quiz.questions.append(question)
        
        question = Question(title: "how_important_is_pregnancy")
        question.options.append(("very_important", [1, 2, 3, 11]))
        question.options.append(("somewhat_important", [4, 5, 6, 7]))
        question.options.append(("not_important", [8, 9, 10, 12]))
        quiz.questions.append(question)
        
        question = Question(title: "what_benefic_interest")
        question.options.append(("regular_period", [2, 6]))
        question.options.append(("lighter_bleeding", [1, 4, 5, 6, 7]))
        question.options.append(("less_cramping", [3, 5, 6, 7]))
        question.options.append(("less_acne", [5, 6, 7]))
        quiz.questions.append(question)
        
        question = Question(title: "what_side_effects_ok")
        question.options.append(("lighter_period", [1, 3, 5, 6, 7]))
        question.options.append(("heavier_period", [2]))
        question.options.append(("weight_gain", [4]))
        question.options.append(("no_side_effects", [8, 9, 10, 11, 12]))
        quiz.questions.append(question)
        
        question = Question(title: "how_stop_using_method")
        question.options.append(("on_my_own", [5, 6, 7, 8, 9, 10, 12]))
        question.options.append(("at_a_clinic", [1, 2, 3, 4]))
        question.options.append(("i_want_permanent_method", [11]))
        quiz.questions.append(question)
        
        responseHandler(quiz)
    }
    
    func resultContraception(quiz: Quiz) -> (String, [Int]) {
        var hasAnswer = false
        var contraceptionCounts = [Int: Int]()
        for index in 1 ... 12 {
            contraceptionCounts[index] = 0
        }
        
        for question in quiz.questions {
            if let answerIndex = question.answerIndex {
                for contraceptionIndex in question.options[answerIndex].1 {
                    if let value = contraceptionCounts[contraceptionIndex] {
                        contraceptionCounts[contraceptionIndex] = value + 1
                        hasAnswer = true
                    }
                }
            }
        }
        
        var resultIndexes = [Int]()
        
        if hasAnswer {
            while resultIndexes.count < 3 {
                var currentMax = contraceptionCounts[0] ?? -1
                var maxKey = 0
                for key in contraceptionCounts.keys {
                    let value = contraceptionCounts[key] ?? -1
                    
                    if currentMax < value {
                        currentMax = value
                        maxKey = key
                    }
                }
                
                if currentMax > 3 {
                    for currentKey in contraceptionCounts.keys {
                        if let value = contraceptionCounts[currentKey] {
                            if value == currentMax {
                                contraceptionCounts[currentKey] = -1
                                resultIndexes.append(currentKey)
                            }
                        }
                    }
                } else {
                    contraceptionCounts[maxKey] = -1
                    resultIndexes.append(maxKey)
                }
            }
        }
        
        let result = (hasAnswer ? "recommended_methods" : "no_recommended_methods").localized
        return (result, resultIndexes)
    }
    
    func requestMenstruationQuiz(responseHandler: @escaping (Quiz?) -> Void) {
        let quiz = Quiz(instructions: "menstruation_quiz_instructions")

        var question = Question(title: "id_prefer_to_get_menstrual_products")
        question.options.append(("at_the_pharmacy", [2, 3, 4, 5, 7]))
        question.options.append(("at_the_grocery_store", [1, 2, 3, 7]))
        question.options.append(("at_the_gas_station", [2, 3, 7]))
        question.options.append(("online", [1, 2, 3, 4, 5, 6, 7]))
        question.options.append(("free_at_a_clinic", [2, 3, 7]))
        quiz.questions.append(question)

        question = Question(title: "id_prefer_to_pay")
        question.options.append(("about_5_10_per_month", [2, 3, 7]))
        question.options.append(("about_15_20_per_month", [5]))
        question.options.append(("about_20_50_one_time", [1, 4, 6]))
        quiz.questions.append(question)

        question = Question(title: "id_like_a_product_i_can_swim_in")
        question.options.append(("yes", [3, 4, 5]))
        question.options.append(("no", [1, 2, 6, 7]))
        quiz.questions.append(question)

        question = Question(title: "i_want_a_product_that_i_only_have_to_change_every")
        question.options.append(("two_four_hours", [1, 2, 3, 7]))
        question.options.append(("four_eight_hours", [3, 6]))
        question.options.append(("up_to_12_hours", [4, 5, 6]))
        quiz.questions.append(question)

        question = Question(title: "id_prefer_a_product_that_i_can")
        question.options.append(("wear_outside_of_my_body", [1, 2, 6, 7]))
        question.options.append(("insert_into_my_body", [3, 4, 5]))
        quiz.questions.append(question)

        responseHandler(quiz)
    }
    
    
    func resultMenstruation(quiz: Quiz) -> (String, [Int]) {
        var hasAnswer = false
        var contraceptionCounts = [Int: Int]()
        for index in 1 ... 7 { // Change the limit to 7
            contraceptionCounts[index] = 0
        }
        
        for question in quiz.questions {
            if let answerIndex = question.answerIndex {
                for contraceptionIndex in question.options[answerIndex].1 {
                    if let value = contraceptionCounts[contraceptionIndex] {
                        contraceptionCounts[contraceptionIndex] = value + 1
                        hasAnswer = true
                    }
                }
            }
        }
        
        var resultIndexes = [Int]()
        
        if hasAnswer {
            while resultIndexes.count < 3 {
                var currentMax = contraceptionCounts[0] ?? -1
                var maxKey = 0
                for key in contraceptionCounts.keys {
                    let value = contraceptionCounts[key] ?? -1
                    
                    if currentMax < value {
                        currentMax = value
                        maxKey = key
                    }
                }
                
                if currentMax > 3 {
                    for currentKey in contraceptionCounts.keys {
                        if let value = contraceptionCounts[currentKey] {
                            if value == currentMax {
                                contraceptionCounts[currentKey] = -1
                                resultIndexes.append(currentKey)
                            }
                        }
                    }
                } else {
                    contraceptionCounts[maxKey] = -1
                    resultIndexes.append(maxKey)
                }
            }
        }
        
        let result = (hasAnswer ? "recommended_methods_menstruation" : "no_recommended_methods_menstruation").localized
        return (result, resultIndexes)
    }


}
