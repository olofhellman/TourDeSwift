//
//  QuestionFormat.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

enum QuestionFormat {    
    case multipleChoice([String])
    case ratingScale(Int)
    case textResponse(String)
}
