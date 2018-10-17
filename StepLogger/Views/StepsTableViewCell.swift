//
//  StepsTableViewCell.swift
//  StepLogger
//
//  Created by Wahid on 10/15/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var numberOfSteps: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    func configure(stepData: StepData) {
        currentDate.text = stepData.dateDescription
        numberOfSteps.text = stepData.numberStepsDescription
        distance.text = stepData.distanceDescription
    }
    
    func configureErrorState() {
        currentDate.isHidden = true
        distance.isHidden = true
        numberOfSteps.text = "Failed to load steps data!"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.borderWidth = 1.0
    }

}
