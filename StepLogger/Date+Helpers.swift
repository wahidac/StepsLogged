//
//  Date+Helpers.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation

// TODO: Unit test if time
extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    var startOfPreviousDay: Date {
        let endOfPreviousDay = startOfDay - 1.0
        return endOfPreviousDay.startOfDay
    }
}
