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
extension StepsDataController {
    func fetchStepsData(numDays: Int, completion: @escaping (([StepData]) -> Void)) {
        // Initialize our upper bound to now
        var upperBound = Date()
        // Initialize our lower bound to the start of today
        var lowerBound: Date = upperBound.startOfDay
        var fetchedData: [StepData] = []
        
        // A dispatch group to synchronize our numDays async calls to the pedometer class.
        let pedometerQuerys = DispatchGroup()
        
        for i in 0..<numDays {
            print("Fetching for upper bound: \(upperBound) and lower bound: \(lowerBound)")

            pedometerQuerys.enter()
            pedometer.queryPedometerData(from: lowerBound, to: upperBound) { (data: CMPedometerData?, error: Error?) in
                print("Fetched for upper bound: \(data?.startDate) and lower bound: \(data?.endDate)")
                
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
}

extension StepsDataController : StepsFetcher {
    func fetchStepsData(numIntervals: Int, intervalSize: IntervalSize, completion: @escaping (([StepData]) -> Void)) {
        //        let testStep1 = StepData(numberOfSteps: 4000, distance: 1200)
        //        let testStep2 = StepData(numberOfSteps: 2000, distance: 2400)
        //        completion([testStep1, testStep2])
        
        fetchStepsData(numDays: numIntervals) { completion($0) }
        
        
        
        //        pedometer.queryPedometerData(from: startOfDay, to: currentMoment) { (data: CMPedometerData?, error: Error?) in
        //            if let error = error {
        //                print("Failed to fetch pedometer data with error: \(error)")
        //                completion([])
        //            } else {
        //                // TODO: Construct the data using API, right now return hard code
        //
        //            }
        //        }
    }
}
