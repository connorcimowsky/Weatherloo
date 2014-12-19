//
//  WeatherTableViewController.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/17/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import UIKit

private let endpoint = "https://api.uwaterloo.ca/v2/weather/current.json"
private let cellIdentifier = "WeatherTableViewControllerCellIdentifier"

class WeatherTableViewController: UITableViewController {
    var processingQueue: NSOperationQueue = NSOperationQueue()
    var currentReading: Reading?
    @IBOutlet weak var statusItem: StatusBarButtonItem!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        self.requestCurrentReading()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "refreshPressed:", forControlEvents: .ValueChanged)
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
    
    @IBAction func refreshPressed(sender: AnyObject) {
        requestCurrentReading()
    }
    
    func requestCurrentReading() {
        let endpointURL = NSURL(string: endpoint)
        let request = NSURLRequest(URL: endpointURL!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        self.statusItem.text = "Fetching data…"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        NSURLConnection.sendAsynchronousRequest(request, queue: self.processingQueue) { (response, data, connectionError) in
            var reading: Reading?
            
            if connectionError == nil {
                var jsonError: NSError?
                if let responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary? {
                    if jsonError == nil {
                        reading = Reading(responseDictionary: responseDictionary)
                    } else {
                        println("JSON deserialization error: \(jsonError?.localizedDescription)")
                    }
                }
            } else {
                println("Connection error: \(connectionError.localizedDescription)")
            }
            
            self.currentReading = reading
            
            dispatch_async(dispatch_get_main_queue()) {
                self.processReading()
            }
        }
    }
    
    func processReading() {
        self.refreshControl?.endRefreshing()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        self.statusItem.text = "Updated \(NSDate().timeAgo().lowercaseString)"
    }
}
