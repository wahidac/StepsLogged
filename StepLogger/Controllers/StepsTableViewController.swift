//
//  StepsTableViewController.swift
//  StepLogger
//
//  Created by Wahid on 10/14/18.
//  Copyright © 2018 Wahid. All rights reserved.
//

import UIKit

class StepsTableViewController: UITableViewController {
    var stepsFetcher: StepsFetcher = StepsDataController()
    var stepDataByDay: [StepData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDataSource()
    }
    
    private func populateDataSource() {
        stepsFetcher.fetchStepsData(numIntervals: 0, intervalSize: .day) { (stepData: [StepData]) in
            stepDataByDay = stepData
            tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepDataByDay?.count ?? 0
    }
}

