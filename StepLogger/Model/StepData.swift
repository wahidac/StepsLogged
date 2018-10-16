//
//  StepData.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation
import CoreMotion

// TODO: Unit test if time, especially the description production
struct StepData {
    // Number of steps
    let numberSteps: Int
    let numberStepsDescription: String
    // Distance in meters
    let distance: Int
    let distanceDescription: String
    // Date
    let lowerBound: Date
    let upperBound: Date
    let dateDescription: String
    
    init?(pedometerData: CMPedometerData) {
        guard let distance = pedometerData.distance else {
            return nil
        }
        
        let numberSteps = Int(truncating: pedometerData.numberOfSteps)
        let distanceAsInt = Int(truncating: distance)
        let lowerBound = pedometerData.startDate
        let upperBound = pedometerData.endDate
        
        self.init(numberOfSteps: numberSteps, distance: distanceAsInt, lowerBound: lowerBound, upperBound: upperBound)
    }
    
    init(numberOfSteps: Int, distance: Int, lowerBound: Date, upperBound: Date) {
        self.numberSteps = numberOfSteps
        self.numberStepsDescription = String(self.numberSteps) + " Steps"
        
        self.distance = distance
        
        let kilometers = Double(self.distance) / Double(1000)
        self.distanceDescription = String(format: "%.2f", kilometers) + " km"
        
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        
        let startOfToday = Date().startOfDay
        if self.lowerBound == startOfToday {
            self.dateDescription = "Today"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            
            self.dateDescription = dateFormatter.string(from: self.lowerBound)
        }
    }
}
