//
//  MacSurveyTakerView.swift
//  scratcher
//
//  Created by Olof Hellman on 6/30/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class MacSurveyTakerView: NSView {
    var currentQuestion: SurveyQuestion?
    @IBOutlet  var questionText: NSTextField?
    @IBOutlet weak var textField: NSTextField?
    @IBOutlet weak var popupButton: NSPopUpButton?
    @IBOutlet weak var slider: NSSlider?
    @IBOutlet weak var sliderMinLabel: NSTextField?
    @IBOutlet weak var sliderMaxLabel: NSTextField?
    @IBOutlet weak var sliderValueLabel: NSTextField?
    @IBOutlet weak var nextButton: NSButton?
    var fileOwner: MacUISurveyTaker?
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder:NSCoder) {
        super.init(coder:coder)
    }


    func present(_ question:SurveyQuestion) {
         currentQuestion = question
         textField?.isHidden = true
         popupButton?.isHidden = true
         popupButton?.removeAllItems()
         slider?.isHidden = true
         sliderMinLabel?.isHidden = true
         sliderMaxLabel?.isHidden = true
         sliderValueLabel?.isHidden = true
         questionText?.isHidden = false
         popupButton?.frame.size.height = 48
         slider?.target = self
         slider?.action = #selector(MacSurveyTakerView.sliderChanged(sender:))
         questionText?.stringValue = question.text
        
         switch (question.format) {
            case .multipleChoice(let choices):
                 popupButton?.isHidden = false
                 popupButton?.addItem(withTitle:"Please choose a response")
                 popupButton?.addItems(withTitles:choices)
                 popupButton?.item(at:0)?.isEnabled = false
                 if var frame = popupButton?.frame {
                     frame.size.height = frame.size.height + 24
                     popupButton?.frame = frame
                 }
            
            case .ratingScale(let max):
                slider?.isHidden = false
                sliderMinLabel?.isHidden = false
                sliderMaxLabel?.isHidden = false
                sliderValueLabel?.isHidden = false
                sliderMinLabel?.stringValue = "0"
                sliderMaxLabel?.stringValue = "\(max)"
                slider?.maxValue =  Double(max)
                slider?.altIncrementValue = Double(1)
                slider?.minValue = 0
                let startingValue = Int (max / 2)
                slider?.integerValue = startingValue
                sliderValueLabel?.stringValue = String(startingValue)

            case .textResponse(let defaultAnswer):
                textField?.isHidden = false
                textField?.stringValue = defaultAnswer
        }
        self.needsDisplay = true

    }
    
    @objc func sliderChanged(sender: AnyObject) {
        if let sliderValue = slider?.integerValue {
            sliderValueLabel?.stringValue = String(sliderValue)
        }
    }
    
    func answer() -> SurveyAnswer? {
         guard let theQuestion = currentQuestion else {
             return nil
         }
        
         switch (theQuestion.format) {
            case .multipleChoice(let choices):
                if let answerString = popupButton?.titleOfSelectedItem {
                    if (choices.contains(answerString)) {
                        return SurveyAnswer.string(answerString)
                    }
                }
                return nil

            case .ratingScale(let max):
                if let sliderVal = slider?.integerValue {
                    return SurveyAnswer.ratingOnRatingScale(sliderVal, max)
                } else {
                    return nil
                }

            case .textResponse(let defaultAnswer):
                if let answerString = textField?.stringValue {
                    if (answerString != defaultAnswer) {
                        return SurveyAnswer.string(answerString)
                    }
                }
                return nil

        }
        return nil
    }
    
    @IBAction func doNext(_ sender: Any) {
        fileOwner?.doNext(sender)
    }
}


