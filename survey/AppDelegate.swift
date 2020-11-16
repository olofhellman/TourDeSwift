//
//  AppDelegate.swift

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
   
        let survey = self.constructSurvey()
        
        // uncomment any or all of the following:
        
        // self.doRandomSurvey(survey)

        // self.doMacSurvey(survey)
        
        self.doRandomSurveyStatistics(survey, count:50)
    }
    
    public func mainWindow() -> NSWindow? {
        return window;
    }

    private func doRandomSurvey(_ survey:Survey) {
        let filledSurvey = RandomSurveyTaker.fill(survey:survey)
        self.endSurvey(filledSurvey)
    }

    private func doMacSurvey(_ survey:Survey) {
        MacUISurveyTaker(survey) {
            finishedSurvey in
            self.endSurvey(finishedSurvey)
        }
    }
    
    private func endSurvey(_ survey:Survey?) {
        survey?.dumpToConsole()
        self.window.close()
        NSApplication.shared.terminate(self)
    }

    private func doRandomSurveyStatistics(_ survey:Survey, count:Int) {
        var surveys:[Survey] = []
        for _ in 0..<count {
            if let completedSurvey = RandomSurveyTaker.maybeFill(survey:survey) {
                surveys.append(completedSurvey)
            }
        }
        self.printMostPopularAnswers(for:surveys)
        self.printAllNames(whoTook:surveys)
        // self.printAllNames(whoTook:surveys, withSubstring:"ry")
    }
        
     private func printMostPopularAnswers(for surveys:[Survey]) {
       // what's the most popular answer to "What is Swift?"
        let whatIsSwiftAnswers:[SurveyAnswer] = surveys.compactMap { let (_,a) = $0.questionsAndAnswers[0]
                                                    return a
                                                 }
        let whatIsSwiftStrings:[String] = whatIsSwiftAnswers.compactMap {
            if case let SurveyAnswer.string(str) = $0 {
                                                          return str
                                                      } else {
                                                          return nil
                                                      }}

        let whatIsSwiftTable:[String:Int]  = whatIsSwiftStrings.reduce(into:[:]) { table, answer in
            let previousValue = table[answer] ?? 0
            table[answer] = previousValue + 1
        }

        let sortedTuples = whatIsSwiftTable.sorted(by: {(a,b) in
            return a.value > b.value
        })
        
        let resultString = sortedTuples.reduce(into:"") { (str, tuple) in
            str = str + "    \(tuple.1): \(tuple.0)\n"
        }
        
        print(
        """
        
          \(surveys.count) randomly filled surveys:
          What is swift? in order of popularity:
        \(resultString)
        """
        )
        
     }

    private func printAllNames(whoTook surveys:[Survey]) {
       let nameAnswers:[SurveyAnswer] = surveys.compactMap { let (_,a) = $0.questionsAndAnswers[2]
                                                    return a
                                                 }
        let names:[String] = nameAnswers.compactMap { if case let SurveyAnswer.string(str) = $0 {
                                                    return str
                                                 } else {
                                                    return nil
                                                 }}
        let uniqueNames = Set(names)
        
        print(
        """
        
          \(surveys.count) randomly filled surveys:
        \(uniqueNames)
        """
        )
    }

    private func printAllNames(whoTook surveys:[Survey], withSubstring substring:String) {
       let nameAnswers:[SurveyAnswer] = surveys.compactMap { let (_,a) = $0.questionsAndAnswers[2]
                                                    return a
                                                 }
        let names:[String] = nameAnswers.compactMap { if case let SurveyAnswer.string(str) = $0 {
                                                    return str
                                                 } else {
                                                    return nil
                                                 }}
        let uniqueNames = Set(names)
        let substringNames = uniqueNames.filter() { $0.contains(substring) }
        let substringNamesString = substringNames.reduce(into:"") { (str, nthName) in
             str = str + "    \(nthName)\n"
        }
        
        print(
        """
        
          \(surveys.count) randomly filled surveys:
          people with \(substring) in their name:
        \(substringNamesString)
        """
        )
    }

    private func constructSurvey() -> Survey {
        var survey = Survey()
        let swiftChoices = ["A bird", "A musician named Taylor", "A bank transfer system", "A programming language"]

        survey.add(question: SurveyQuestion("What is Swift?", choices:swiftChoices))
        survey.add(question: SurveyQuestion("Do you like Swift?", ratingScale:7))
        survey.add(question: SurveyQuestion("What's your name?", defaultAnswer:"<Your Name Here>"))
        
        return survey
    }
}

