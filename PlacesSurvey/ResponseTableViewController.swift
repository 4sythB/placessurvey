//
//  ResponseTableViewController.swift
//  PlacesSurvey
//
//  Created by Brad on 7/21/16.
//  Copyright © 2016 Brad Forsyth. All rights reserved.
//

import UIKit

class ResponseTableViewController: UITableViewController {
    
    var surveys: [Survey] = []

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        SurveyController.getSurvey { (surveys) in
            self.surveys = surveys
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return surveys.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("responseCell", forIndexPath: indexPath)

        let response = surveys[indexPath.row]
        
        cell.textLabel?.text = response.name
        cell.detailTextLabel?.text = response.response

        return cell
    }
}
