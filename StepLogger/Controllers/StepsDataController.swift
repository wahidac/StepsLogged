//
//  StepsDataController.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreMotion

class StepsDataController {
    let pedometer: CMPedometer = CMPedometer()
    // 7 is the max number of days we can request data from CMPedometer
    let maxNumDays: Int = 7
}

extension StepsDataController : StepsFetcher {
    func fetchDailyStepsData(numDays: Int, completion: @escaping (([StepData]) -> Void)) {
        // Initialize our upper bound to now
        let upperBound = Date()
        var lowerBound: Date = upperBound.startOfDay
        let oneDay: TimeInterval = 60 * 60 * 24
        
        // Initialize our lower bound to numDays - 1 back ( the current day is day 1, that's why we subtract 1 )
        for _ in 1..<min(numDays, maxNumDays) {
            lowerBound = lowerBound.startOfPreviousDay
        }
        fetchGranularStepsData(lowerBound: lowerBound, upperBound: upperBound, intervalSize: oneDay) { (stepData: [StepData]) in
            let sortedData = stepData.sorted(by: { (a: StepData, b: StepData) -> Bool in
                return a.lowerBound > b.lowerBound
            })
            completion(sortedData)
        }
    }
    
    // TODO: Fix issue w/ duplicate data for TODAY
    func fetchGranularStepsData(lowerBound: Date, upperBound: Date, intervalSize: TimeInterval, completion: @escaping (([StepData]) -> Void)) {
        var fetchedData: [StepData] = []
        var currentLowerBound = lowerBound
        var currentLowerBoundPlusIntervalSize = lowerBound.addingTimeInterval(intervalSize)
        
        // A dispatch group to synchronize our numDays async calls to the pedometer class.
        let pedometerQuerys = DispatchGroup()
        
        // TODO: Fix problem w/ last data entry
        while currentLowerBound < upperBound {
            pedometerQuerys.enter()
            
            let queryUpperBound = min(currentLowerBoundPlusIntervalSize, upperBound)
            pedometer.queryPedometerData(from: currentLowerBound, to: queryUpperBound) { (data: CMPedometerData?, error: Error?) in
                if let error = error {
                    print("Failed to fetch pedometer data with error: \(error)")
                } else if let data = data, let stepData = StepData(pedometerData: data) {
                    fetchedData.append(stepData)
                }
                
                pedometerQuerys.leave()
            }
            
            // Update the lower bound and upper bound
            currentLowerBound = currentLowerBoundPlusIntervalSize
            currentLowerBoundPlusIntervalSize = currentLowerBound.addingTimeInterval(intervalSize)
        }
        
        // Once all the querys have, finished execute the callback, passing in the data sorted by most recent to latest
        pedometerQuerys.notify(queue: DispatchQueue.main) {
            completion(fetchedData.sorted(by: { (a: StepData, b: StepData) -> Bool in
                a.lowerBound < b.lowerBound
            }))
        }
    }
}
