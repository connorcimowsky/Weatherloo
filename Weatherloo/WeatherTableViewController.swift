//
//  WeatherTableViewController.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/17/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import UIKit
import WeatherlooData

private let cellIdentifier = "WeatherTableViewControllerCellIdentifier"

class WeatherTableViewController: UITableViewController {
    var currentReading: Reading?
    @IBOutlet weak var statusItem: StatusBarButtonItem!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "refreshPressed:", forControlEvents: .ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let formattedWeatherConditions = self.currentReading?.formattedWeatherConditions() {
            return formattedWeatherConditions.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        cell.textLabel?.text = self.currentReading?.formattedWeatherConditions()[indexPath.row].name
        cell.detailTextLabel?.text = self.currentReading?.formattedWeatherConditions()[indexPath.row].value
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let formattedObservationTime = self.currentReading?.formattedObservationTime() {
            return "Current Reading: \(formattedObservationTime)"
        }
        
        return nil
    }
    
    // MARK: - Internal Methods
    
    func applicationDidBecomeActive(notification: NSNotification) {
        requestCurrentReading()
    }
    
    @IBAction func refreshPressed(sender: AnyObject) {
        requestCurrentReading()
    }
    
    func requestCurrentReading() {
        self.statusItem.text = "Fetching data…"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        requestWeatherData { (response, error) in
            self.currentReading = (error == nil) ? Reading(responseDictionary: response!) : nil
            self.processReading()
        }
    }
    
    func processReading() {
        self.refreshControl?.endRefreshing()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        
        if self.currentReading != nil {
            self.statusItem.text = "Updated \(NSDate().timeAgo().lowercaseString)"
        } else {
            self.statusItem.text = "Weather station unavailable"
        }

    }
}
