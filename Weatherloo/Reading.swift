//
//  Reading.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/16/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import Foundation

struct Reading {
    var observationTime: NSDate?
    var observationTimeZone: NSTimeZone?
    var temperature: Double?
    var humidex: Double?
    var windChill: Double?
    var relativeHumidity: Double?
    var dewPoint: Double?
    var windSpeed: Double?
    var windDirection: Double?
    var pressure: Double?
    var pressureTrend: String?
    var radiation: Double?
    
    init(responseDictionary: NSDictionary) {
        if let observationData = responseDictionary["data"] as? NSDictionary {
            if let observationTimeString = observationData["observation_time"] as? String {
                self.observationTime = ISO8601DateFormatter().dateFromString(observationTimeString, timeZone: &self.observationTimeZone)
            }
            
            self.temperature = observationData["temperature_current_c"] as? Double
            self.humidex = observationData["humidex_c"] as? Double
            self.windChill = observationData["windchill_c"] as? Double
            self.relativeHumidity = observationData["relative_humidity_percent"] as? Double
            self.dewPoint = observationData["dew_point_c"] as? Double
            self.windSpeed = observationData["wind_speed_kph"] as? Double
            self.windDirection = observationData["wind_direction_degrees"] as? Double
            self.pressure = observationData["pressure_kpa"] as? Double
            self.pressureTrend = observationData["pressure_trend"] as? String
            self.radiation = observationData["incoming_shortwave_radiation_wm2"] as? Double
        }
    }
}
