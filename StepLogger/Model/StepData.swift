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
    let numberSteps: Int
    let distance: Int
    
    init?(pedometerData: CMPedometerData) {
        guard let numberSteps = pedometerData.numberOfSteps, let distance = pedometerData.distance else {
            return nil
        }
        
        self.numberSteps = numberSteps
        self.distance = distance
    }
}
