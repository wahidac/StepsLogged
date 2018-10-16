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
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsTableViewCell", for: indexPath)
            as! StepsTableViewCell
        guard let stepData = stepDataByDay else {
            cell.configureErrorState()
            print("Failed to retrieve data for indexPath: \(indexPath).")
            return cell
        }

        let dayData = stepData[indexPath.row]
        cell.configure(date: "Today", stepData: dayData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepDataByDay?.count ?? 0
    }
}

