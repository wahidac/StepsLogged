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

extension StepsDataController : StepsFetcher {
    func fetchStepsData(numIntervals: Int, intervalSize: IntervalSize, completion: (([StepData]) -> Void)) {
        let testStep1 = StepData(numberOfSteps: 4000, distance: 1200)
        let testStep2 = StepData(numberOfSteps: 2000, distance: 2400)
        completion([testStep1, testStep2])
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
