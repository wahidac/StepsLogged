//
//  StepsDetailViewController.swift
//  StepLogger
//
//  Created by Wahid on 10/16/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit

class StepsDetailViewController: UIViewController {
    var detailedStepData: [StepData]? {
        didSet {
            // TODO: Reload the view we are rendering
            for step in detailedStepData! {
                print(step)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
