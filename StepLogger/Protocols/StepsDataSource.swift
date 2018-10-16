//
//  StepsDataSource.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreMotion

protocol StepsDataSource {
    /**
      Returns step data for the number of days backwards specified.
     
     - returns: Dictionary w/ keys of Date and values of CMPedometerData
     - parameter numDays: Number of days back to return data for
     
     */
    func fetchStepsData(numDays: Int) -> [Date: StepData]
    var mostRecentlyFetched: [StepData] { get }
}
