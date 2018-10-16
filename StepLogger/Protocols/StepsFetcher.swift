//
//  StepsFetcher.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreMotion

enum IntervalSize {
    case day
    case hour
    // Add anymore intervals we might need here
}

protocol StepsFetcher {
    /**
      Returns step data.
     
     - returns: Array of step data, with the first element pointing to the current
    interval and the subsequent intervals following in order from most recent to latest
     - parameter numIntervals: Number of intervals back to return data for
     - parameter intervalSize: Size of an interval (day, hour, second, etc.)
     - parameter completion: closure to execute on completion.
     */
    func fetchStepsData(numIntervals: Int, intervalSize: IntervalSize, completion: (([StepData]) -> Void))
}
