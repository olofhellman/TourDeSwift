//
//  MacSurveyTaker.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class MacUISurveyTaker : NSObject, Surveyor  {

    var survey:Survey
    var completedSurvey:Survey
    var currentQuestionIndex:Int
    var currentQuestion:SurveyQuestion?
    var completionHandler:(Survey) -> Void
    @IBOutlet var surveyTakerView:MacSurveyTakerView?
    
    required init (_ unfilledSurvey:Survey, finished: @escaping (Survey) -> Void)  {
        completionHandler = finished
        survey = unfilledSurvey
        completedSurvey = Survey()
        currentQuestionIndex = 0
        currentQuestion = nil
        super.init()

        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else {
            finished (survey)
            return
        }
        guard let mainWindow = appDelegate.mainWindow() else {
            finished (survey)
            return
        }
        guard let contentView = mainWindow.contentView else {
            finished (survey)
            return
        }

        Bundle.main.loadNibNamed("MacSurveyTakerView", owner:self, topLevelObjects:nil);

        if let sv = surveyTakerView {
            contentView.addSubview(sv)
            sv.isHidden = false
            sv.fileOwner = self
        }
        presentCurrentQuestion()
    }

    func presentCurrentQuestion() {
        let (surveyQuestion, _) = survey.questionsAndAnswers[currentQuestionIndex]
        currentQuestion = surveyQuestion
        surveyTakerView?.present(surveyQuestion)
    }
    
    @IBAction func doNext(_ sender: Any) {

        //record current answer
        let surveyAnswer = surveyTakerView?.answer()
        if let question = currentQuestion   {
            completedSurvey.add(question:question, andAnswer:surveyAnswer)
        }
        
        // see if we are done with survey
        currentQuestionIndex = currentQuestionIndex + 1
        if (currentQuestionIndex >= survey.questionsAndAnswers.count) {
           surveyTakerView?.fileOwner = nil
           completionHandler (completedSurvey)
        }
        //if not, go to next question
        else {
            self.presentCurrentQuestion()
        }
    }
}
