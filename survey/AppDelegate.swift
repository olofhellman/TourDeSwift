//
//  AppDelegate.swift
//  scratcher
//
//  Created by Olof Hellman on 6/26/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
   
        let survey = self.constructSurvey()
        
        //self.doRandomSurvey(survey)

        self.doMacSurvey(survey)
        
        //self.doRandomSurveyStatistics(survey)
    }
    
    func doRandomSurvey(_ survey:Survey) {
        let filledSurvey = RandomSurveyTaker.fill(survey:survey)
        self.endSurvey(filledSurvey)
    }

    func doMacSurvey(_ survey:Survey) {
        MacUISurveyTaker(survey) {
            finishedSurvey in
            self.endSurvey(finishedSurvey)
        }
    }
    
    func endSurvey(_ survey:Survey?) {
        survey?.dumpToConsole()
        self.window.close()
        NSApplication.shared.terminate(self)
    }

    func doRandomSurveyStatistics(_ survey:Survey) {
        var surveyArray:[Survey] = []
        for i in 0..<100 {
            if let completedSurvey = RandomSurveyTaker.maybeFill(survey:survey) {
                surveyArray.append(completedSurvey)
            }
        }
        
        // what's the most popular answer to "What is Swift?"
        let whatIsSwiftAnswers:[SurveyAnswer] = surveyArray.compactMap { let (_,a) = $0.questionsAndAnswers[0]
                                                    return a
                                                 }
        let whatIsSwiftStrings:[String] = whatIsSwiftAnswers.compactMap { if case let SurveyAnswer.string(str) = $0 {
                                                    return str
                                                 } else {
                                                    return nil
                                                 }}
 
        let whatIsSwiftTable:[String:Int]  = whatIsSwiftStrings.reduce(into:[:]) { table, answer in
            let previousValue = table[answer] ?? 0
            table[answer] = previousValue + 1
        }

        let sortedAnswers = whatIsSwiftTable.sorted(by: {(a,b) in
            return a.value > b.value
        })
        
        print("100 randomly filled surveys:")
        print("  What is swift? in order of popularity:")
        sortedAnswers.forEach({ (key, value) in
             print ("    \(value): \(key)")
        })

 

        let nameAnswers:[SurveyAnswer] = surveyArray.compactMap { let (_,a) = $0.questionsAndAnswers[2]
                                                    return a
                                                 }
        let names:[String] = nameAnswers.compactMap { if case let SurveyAnswer.string(str) = $0 {
                                                    return str
                                                 } else {
                                                    return nil
                                                 }}
        let uniqueNames = Set(names)
        
        let ryNames = uniqueNames.filter() { $0.contains("ry") }
        print("100 randomly filled surveys:")
        print("  Names that contain a 'ry'")
        ryNames.forEach({ (name) in
             print ("    \(name)")
        })

        
    }

    func constructSurvey() -> Survey {
        var survey = Survey()
        let swiftChoices = ["A bird", "A musician named Taylor", "A bank transfer system", "A programming language"]

        survey.add(question: SurveyQuestion("What is Swift?", choices:swiftChoices))
        survey.add(question: SurveyQuestion("Do you like Swift?", ratingScale:7))
        survey.add(question: SurveyQuestion("What's your name?", defaultAnswer:"<Your Name Here>"))
        
        return survey
    }
    
    func mainWindow() -> NSWindow? {
        return window;
    }
}

