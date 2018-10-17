//
//  StepsFetcher.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreMotion

protocol StepsFetcher {
    var maxNumDays: Int { get }
    /**
      Returns daily step data.
     
     - returns: Array of daily step data, ordered by the current day to the least recent day
     - parameter numDays: Number of days back to return data for. 1 Returns the data for today, 2 returns data for today and yesterday, etc...The max this can be is 7
     - parameter completion: closure to execute on completion.
     */
    func fetchDailyStepsData(numDays: Int, completion: @escaping (([StepData]) -> Void))
    
    
    /**
     Returns granular step data. Use this to calculate steps at a granularity finer than a day. For example, the number of steps taken between
     1:00 PM and 2:00 PM Yesterday. This returns data for intervals of size intervalSize seconds starting from the lowerBound and continuing
     until we hit the upper bound
     
     - returns: Array of step data, ordered by least recent to most recent
     - parameter lowerBound: Earliest time in history to consider
     - parameter upperBound: Latest time in history to consider
     - parameter intervalSize: The size of the intervals to consider
     - parameter completion: closure to execute on completion.
     */
    func fetchGranularStepsData(lowerBound: Date, upperBound: Date, intervalSize: TimeInterval, completion: @escaping (([StepData]) -> Void))
}

extension StepsFetcher {
    // 7 is the max number of days we can request data from CMPedometer
    var maxNumDays: Int {
        return 7
    }
}
