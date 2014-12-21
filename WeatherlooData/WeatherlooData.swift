//
//  WeatherlooData.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/21/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import Foundation

let endpoint = "https://api.uwaterloo.ca/v2/weather/current.json"

// MARK: - Public Methods

public func requestWeatherData(completion: (response: NSDictionary?, error: NSError?) -> Void) {
    let endpointURL = NSURL(string: endpoint)
    let request = NSURLRequest(URL: endpointURL!)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, connectionError) in
        if connectionError == nil {
            var jsonError: NSError?
            if let responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as NSDictionary? {
                if jsonError == nil {
                    completion(response: responseDictionary, error: nil)
                } else {
                    println("JSON deserialization error: \(jsonError?.localizedDescription)")
                    completion(response: nil, error: jsonError)
                }
            }
        } else {
            println("Connection error: \(connectionError.localizedDescription)")
            completion(response: nil, error: connectionError)
        }
    }
}