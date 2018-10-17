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
}

// // MARK: Fetching helper methods
extension StepsDataController : StepsFetcher {
    func fetchDailyStepsData(numDays: Int, completion: @escaping (([StepData]) -> Void)) {
        // Initialize our upper bound to now
        var upperBound = Date()
        // Initialize our lower bound to the start of today
        var lowerBound: Date = upperBound.startOfDay
        var fetchedData: [StepData] = []
        
        // A dispatch group to synchronize our numDays async calls to the pedometer class.
        let pedometerQuerys = DispatchGroup()
        
        // TODO: Fix problem w/ last data entry
        for _ in 0..<numDays {
            pedometerQuerys.enter()
            pedometer.queryPedometerData(from: lowerBound, to: upperBound) { (data: CMPedometerData?, error: Error?) in
                if let error = error {
                    print("Failed to fetch pedometer data with error: \(error)")
                } else if let data = data, let stepData = StepData(pedometerData: data) {
                    fetchedData.append(stepData)
                }
                
                pedometerQuerys.leave()
            }
            
            // Update the lower bound and upper bound
            upperBound = lowerBound
            lowerBound = upperBound.startOfPreviousDay
        }
        
        // Once all the querys have, finished execute the callback, passing in the data sorted by most recent to latest
        pedometerQuerys.notify(queue: DispatchQueue.main) {
            completion(fetchedData.sorted(by: { (a: StepData, b: StepData) -> Bool in
                a.lowerBound > b.lowerBound
            }))
        }
    }
    
    // TODO: Consume this in the above if time
    func fetchGranularStepsData(lowerBound: Date, upperBound: Date, intervalSize: TimeInterval, completion: @escaping (([StepData]) -> Void)) {
        var fetchedData: [StepData] = []
        var currentLowerBound = lowerBound
        var currentLowerBoundPlusIntervalSize = lowerBound.addingTimeInterval(intervalSize)
        
        // A dispatch group to synchronize our numDays async calls to the pedometer class.
        let pedometerQuerys = DispatchGroup()
        
        // TODO: Fix problem w/ last data entry
        while currentLowerBoundPlusIntervalSize < upperBound {
            pedometerQuerys.enter()
            
            pedometer.queryPedometerData(from: currentLowerBound, to: currentLowerBoundPlusIntervalSize) { (data: CMPedometerData?, error: Error?) in
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
