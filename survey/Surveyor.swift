//
//  Surveyor.swift
//  scratcher
//
//  Created by Olof Hellman on 6/29/19.
//  Copyright © 2019 Olof Hellman. All rights reserved.
//

import Foundation

protocol Surveyor {
    init(_ survey:Survey, finished: @escaping (Survey) -> Void)
}
