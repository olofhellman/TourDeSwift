//
//  Survey.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

struct Survey {
    var questionsAndAnswers:[(SurveyQuestion, SurveyAnswer?)]
    
    init() {
        questionsAndAnswers = []
    }
    
    mutating func add(question surveyQuestion:SurveyQuestion) {
        questionsAndAnswers.append((surveyQuestion, nil))
    }
    
    mutating func add(question surveyQuestion:SurveyQuestion, andAnswer answer:SurveyAnswer?) {
        questionsAndAnswers.append((surveyQuestion, answer))
    }
    
    func dumpToConsole() {
        for (question, answer) in self.questionsAndAnswers {
           print("Q:\(question.text)")
           
           switch answer {
               case .none:
                print("A: no answer")
            
               case .some(.string(let str)):
                print("A: \(str)")
            
               case .some(.ratingOnRatingScale(let rating, let maxScale)):
                print("A: \(rating) out of \(maxScale)")
            }
            print("")
        }
    }
}
