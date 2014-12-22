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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.processReading()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        self.requestCurrentReading()
        
        if self.currentReading == nil {
            completionHandler(.Failed)
        } else {
            completionHandler(.NewData)
        }
    }
    
    func requestCurrentReading() {
        requestWeatherData { (reading, error) in
            self.currentReading = reading
            self.processReading()
        }
    }
    
    func processReading() {
//        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
//        
//        if self.currentReading != nil {
//            self.statusItem.text = "Updated \(NSDate().timeAgo().lowercaseString)"
//        } else {
//            self.statusItem.text = "Weather station unavailable"
//        }
    }
}
