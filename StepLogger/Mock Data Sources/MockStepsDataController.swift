//
//  MockStepsDataController.swift
//  StepLogger
//
//  Created by Wahid on 10/16/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import Foundation

// A data controller that returns mocked data to be shown in the case that we are on a simulator!
class MockStepsDataController {
    let referenceDate = Date(timeIntervalSince1970: 1000000000.0)
    var startDayOne: Date!
    var startDayTwo: Date!
    var startDayThree: Date!
    
    init() {
        startDayOne = referenceDate.startOfDay
        startDayTwo = startDayOne.startOfPreviousDay
        startDayThree = startDayTwo.startOfPreviousDay
    }
}

extension MockStepsDataController : StepsFetcher {
    func fetchDailyStepsData(numDays: Int, completion: @escaping (([StepData]) -> Void)) {
        let stepDataOne = StepData(numberOfSteps: 6709, distance: 4530, lowerBound: startDayOne, upperBound: referenceDate)
        let stepDataTwo = StepData(numberOfSteps: 4324, distance: 3542, lowerBound: startDayTwo, upperBound: startDayOne)
        let stepDataThree = StepData(numberOfSteps: 7232, distance: 5255, lowerBound: startDayThree, upperBound: startDayTwo)
        completion([stepDataOne, stepDataTwo, stepDataThree])
    }
    
    func fetchGranularStepsData(lowerBound: Date, upperBound: Date, intervalSize: TimeInterval, completion: @escaping (([StepData]) -> Void)) {
        let timeIntervalToAdd: TimeInterval = 60 * 60 * 3 // 3 hours
        
        var lowerBound = startDayThree!
        var upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let first = StepData(numberOfSteps: 565, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let second = StepData(numberOfSteps: 1654, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let third = StepData(numberOfSteps: 934, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let fourth = StepData(numberOfSteps: 342, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let fifth = StepData(numberOfSteps: 122, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let sixth = StepData(numberOfSteps: 435, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let seventh = StepData(numberOfSteps: 100, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        lowerBound = upperBound
        upperBound = lowerBound.addingTimeInterval(timeIntervalToAdd)
        let eigth = StepData(numberOfSteps: 125, distance: 1000, lowerBound: lowerBound, upperBound: upperBound)
        
        completion([first, second, third, fourth, fifth, sixth, seventh, eigth])
    }
    
    
}
