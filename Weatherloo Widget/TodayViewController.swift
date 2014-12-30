//
//  TodayViewController.swift
//  Weatherloo Widget
//
//  Created by Connor Cimowsky on 12/20/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    var currentReading: Reading?
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - UIViewController
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.processReading()
    }
    
    // MARK: - NCWidgetProviding
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        Flurry.logEvent("Widget update")
        
        requestWeatherData { (reading, error) in
            self.currentReading = reading
            self.processReading()
            
            if self.currentReading == nil {
                completionHandler(.Failed)
            } else {
                completionHandler(.NewData)
            }
        }
    }
    
    // MARK: - Internal Methods
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        self.extensionContext?.openURL(NSURL(string: "weatherloo:")!, completionHandler: nil)
    }
    
    func processReading() {
        if let formattedTemperature = self.currentReading?.formattedTemperature() {
            self.temperatureLabel.text = formattedTemperature
            
            if let formattedHumidex = self.currentReading?.formattedHumidex() {
                self.temperatureLabel.text = "\(formattedTemperature) (feels like \(formattedHumidex))"
            } else if let formattedWindChill = self.currentReading?.formattedWindChill() {
                self.temperatureLabel.text = "\(formattedTemperature) (feels like \(formattedWindChill))"
            }
        } else {
            self.temperatureLabel.text = "-- ºC"
        }
        
        if let formattedObservationTime = self.currentReading?.formattedObservationTime() {
            self.statusLabel.text = "Current Reading: \(formattedObservationTime)"
            self.preferredContentSize = CGSizeMake(320.0, 70.0)
        } else {
            self.statusLabel.text = nil
            self.preferredContentSize = CGSizeMake(320.0, 45.0)
        }
    }
}
