//
//  Sum.swift
//  ProjectEuler
//
//  Created by Andrew McKnight on 1/11/16.
//  Copyright © 2016 AMProductions. All rights reserved.
//

import Foundation
import PippinLibrary

public extension Sequence where Iterator.Element: AdditiveArithmetic {
    var sum: Iterator.Element {
        reduce((0 as! Self.Element), +)
    }
}
