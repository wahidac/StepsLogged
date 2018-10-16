//
//  StepData.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreMotion

struct StepData {
    // Number of steps
    let numberSteps: Int
    // Distance in meters
    let distance: Int
    
    init?(pedometerData: CMPedometerData) {
        guard let distance = pedometerData.distance else {
            return nil
        }

        self.numberSteps = Int(truncating: pedometerData.numberOfSteps)
        self.distance = Int(truncating: distance)
    }
    
    init(numberOfSteps: Int, distance: Int) {
        self.numberSteps = numberOfSteps
        self.distance = distance
    }
}
