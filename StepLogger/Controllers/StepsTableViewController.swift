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
    
    // Constants
    let numDaysToRequest = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDataSource()
    }
    
    private func populateDataSource() {
        stepsFetcher.fetchStepsData(numIntervals: numDaysToRequest, intervalSize: .day) { [weak self] (stepData: [StepData]) in
            self?.stepDataByDay = stepData
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsTableViewCell", for: indexPath)
            as! StepsTableViewCell
        guard let stepData = stepDataByDay else {
            cell.configureErrorState()
            print("Failed to retrieve data for indexPath: \(indexPath).")
            return cell
        }

        let dayData = stepData[indexPath.row]
        cell.configure(stepData: dayData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepDataByDay?.count ?? 0
    }
    
    // MARK: UITableViewDelegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Spin up a detail view controller and push it onto the nav stack
    }
}

