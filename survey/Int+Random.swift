//
//  Int+Random.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

extension Int {
    func randomValue() -> Int {
        return Int.random(in: 1...self)
    }
}
