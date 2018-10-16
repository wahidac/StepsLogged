//
//  Date+Helpers.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
