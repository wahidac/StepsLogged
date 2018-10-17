//
//  StepsDetailViewController.swift
//  StepLogger
//
//  Created by Wahid on 10/16/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit

// Display a line graph that shows our step activity broken down in 3 hour intervals
class StepsDetailViewController: UIViewController {
    @IBOutlet weak var stepsDetailGraphView: StepsDetailGraphView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var maxSteps: UILabel!
    
    var detailedStepData: [StepData] = [] {
        didSet {
            updateDetailView()
        }
    }
    
    private func updateDetailView() {
        var graphPoints: [Int] = []
        var lastPoint = 0
        let labelFormatter = DateFormatter()
        labelFormatter.dateFormat = "h a"
        
        for step in detailedStepData {
            lastPoint += step.numberSteps
            graphPoints.append(lastPoint)
            
            // Create a time label for the data point
            let timeLabel = UILabel(frame: .zero)
            timeLabel.font = UIFont.systemFont(ofSize: 10.0)
            timeLabel.text = labelFormatter.string(from: step.upperBound)
            timeLabel.textAlignment = .center
            stackView.addArrangedSubview(timeLabel)
        }
        
        stepsDetailGraphView.graphPoints = graphPoints
        maxSteps.text = String(lastPoint)
        
        // Redraw the view
        self.stepsDetailGraphView.setNeedsDisplay()
    }
}
