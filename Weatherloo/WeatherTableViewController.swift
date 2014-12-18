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
    
    override func viewDidLoad() {
        self.requestCurrentReading()
    }
    
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
        if let reading = self.currentReading {
            if let formattedObservationTime = reading.formattedObservationTime() {
                return "Current Reading: \(formattedObservationTime)"
            }
        }
        
        return nil
    }
    
    func requestCurrentReading() {
        let endpointURL = NSURL(string: endpoint)
        let request = NSURLRequest(URL: endpointURL!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
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
                self.updateTableView()
            }
        }
    }
    
    func updateTableView() {
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
}
