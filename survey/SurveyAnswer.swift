//
//  SurveyAnswer.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

enum SurveyAnswer {
    case string(String)
    case ratingOnRatingScale(Int, Int)
    
    func dumpToConsole() {
        switch self {
            case .string(let str):
            print("A: \(str)")
            
            case .ratingOnRatingScale(let rating, let maxScale):
            print("A: \(rating) out of \(maxScale)")
        }
        print("")
    }
}
