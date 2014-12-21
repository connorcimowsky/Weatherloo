//
//  Reading.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/16/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import Foundation

public struct Reading {
    public var timestamp: String?
    public var temperature: Double?
    public var humidex: Double?
    public var windChill: Double?
    public var relativeHumidity: Double?
    public var dewPoint: Double?
    public var windSpeed: Double?
    public var windDirection: Double?
    public var pressure: Double?
    public var pressureTrend: String?
    public var radiation: Double?
    
    // MARK: - Lifecycle
    
    public init(responseDictionary: NSDictionary) {
        if let observationData = responseDictionary["data"] as? NSDictionary {
            self.timestamp = observationData["observation_time"] as? String
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
