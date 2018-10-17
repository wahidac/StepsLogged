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
    // 7 is the max number of days we can request data from CMPedometer
    let numDaysToRequest = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDataSource()
    }
    
    private func populateDataSource() {
        stepsFetcher.fetchDailyStepsData(numDays: numDaysToRequest) { [weak self] (stepData: [StepData]) in
            self?.stepDataByDay = stepData
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow, let stepDataByDay = stepDataByDay  else {
            print("Failed to retrieve data before presenting detail view controller.")
            return
        }
        
        let stepData = stepDataByDay[indexPath.row]
        let detailViewController = segue.destination as! StepsDetailViewController
        // Fetch data for every 3 hours
        stepsFetcher.fetchGranularStepsData(lowerBound: stepData.lowerBound, upperBound: stepData.upperBound, intervalSize: 60 * 60 * 3) { (stepData: [StepData]) in
            detailViewController.detailedStepData = stepData
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
}

