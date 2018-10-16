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
    let numberStepsDescription: String
    // Distance in meters
    let distance: Int
    let distanceDescription: String
    // Date
    // TODO: Insert date and some description for our cell
    
    init?(pedometerData: CMPedometerData) {
        guard let distance = pedometerData.distance else {
            return nil
        }
        
        let numberSteps = Int(truncating: pedometerData.numberOfSteps)
        let distanceAsInt = Int(truncating: distance)
        self.init(numberOfSteps: numberSteps, distance: distanceAsInt)
    }
    
    init(numberOfSteps: Int, distance: Int) {
        self.numberSteps = numberOfSteps
        self.numberStepsDescription = String(self.numberSteps)
        
        self.distance = distance
        
        let kilometers = Double(self.distance) / Double(1000)
        self.distanceDescription = String(format: "%.2f", kilometers) + " km"
    }
}
