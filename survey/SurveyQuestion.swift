//
//  SurveyQuestion.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

struct SurveyQuestion {
    let text:String
    let format:QuestionFormat
    
    init(_ t:String, choices:[String]) {
        text = t
        format = QuestionFormat.multipleChoice(choices)
    }
    
    init(_ t:String, ratingScale:Int) {
        text = t
        format = QuestionFormat.ratingScale(ratingScale)
    }
    
    init(_ t:String, defaultAnswer:String) {
        text = t
        format = QuestionFormat.textResponse(defaultAnswer)
    }
}

