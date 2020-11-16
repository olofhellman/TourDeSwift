//
//  RandomSurveyTaker.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

class RandomSurveyTaker : Surveyor {

    required init(_ survey:Survey, finished: @escaping (Survey) -> Void) {
        let completedSurvey = RandomSurveyTaker.fill(survey:survey)
        finished (completedSurvey)
    }
    
    class func maybeFill(survey: Survey) -> Survey? {
        guard 7.randomValue() < 7 else { return nil }
        return fill(survey:survey)
    }
    
    class func fill(survey: Survey) -> Survey {
        var completedSurvey = Survey()
        for (question, _) in survey.questionsAndAnswers {
           let answer = randomAnswerTo(question: question)
           completedSurvey.add(question:question, andAnswer:answer)
        }
        return completedSurvey
    }
    
    class func randomAnswerTo(question: SurveyQuestion) -> SurveyAnswer? {
        guard 7.randomValue() < 7 else { return nil }
        
        switch question.format {
            case .multipleChoice(let choices):
                guard let randomChoice = choices.randomElement() else { return nil }
                return SurveyAnswer.string(randomChoice)
            
            case .ratingScale(let scale):
                return SurveyAnswer.ratingOnRatingScale(scale.randomValue(), scale)
            
            case .textResponse(let defaultAnswer):
                return SurveyAnswer.string(self.ridiculousName())
        }
    }
    
    class func ridiculousName() -> String {
        let firstWords = ["Theon", "Cersei", "Sansa", "Arya", "Jon", "Daenerys", "Gregor", "Tyrian", "Brienne", "Ramsey", "Khal", "Missandei", "Samwell", "Ellaria", "Ygritte", "Jora", "Tywin", "Gilly"]
        let secondWords = ["Kirk", "McCoy", "Sulu", "Picard", "Riker", "Uhura", "Sisko", "Troi", "Janeway", "Pike", "Chekov", "Crusher", "La Forge", "Yar", "Nerys", "Torres", "Burnham", "of Nine", "O'Brien", "Tilly", "Worf", "Georgiou"]

        let firstName = firstWords.randomElement() ?? ""
        let secondName = secondWords.randomElement() ?? ""

        return firstName + " " + secondName
    }
}
