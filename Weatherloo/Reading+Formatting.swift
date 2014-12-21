//
//  Reading+Formatting.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/21/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import Foundation
import WeatherlooData

extension Reading {
    var observationTime: NSDate? {
        get {
            return ISO8601DateFormatter().dateFromString(self.timestamp?, timeZone: nil)
        }
    }
    
    var observationTimeZone: NSTimeZone? {
        get {
            var timeZone: NSTimeZone?
            let time = ISO8601DateFormatter().dateFromString(self.timestamp?, timeZone: &timeZone)
            return timeZone
        }
    }
    
    func formattedObservationTime() -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = self.observationTimeZone
        dateFormatter.dateStyle = .NoStyle;
        dateFormatter.timeStyle = .ShortStyle;
        
        if let observationTime = self.observationTime {
            return dateFormatter.stringFromDate(observationTime)
        }
        
        return nil
    }
    
    func formattedTemperature() -> String? {
        if let temperature = self.temperature {
            return "\(NSNumberFormatter.localizedStringFromNumber(temperature, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedHumidex() -> String? {
        if let humidex = self.humidex {
            return "\(NSNumberFormatter.localizedStringFromNumber(humidex, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedWindChill() -> String? {
        if let windChill = self.windChill {
            return "\(NSNumberFormatter.localizedStringFromNumber(windChill, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedRelativeHumidity() -> String? {
        if let relativeHumidity = self.relativeHumidity {
            return "\(NSNumberFormatter.localizedStringFromNumber(relativeHumidity, numberStyle: .DecimalStyle))%"
        }
        
        return nil
    }
    
    func formattedDewPoint() -> String? {
        if let dewPoint = self.dewPoint {
            return "\(NSNumberFormatter.localizedStringFromNumber(dewPoint, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedWindSpeedAndDirection() -> String? {
        if let windSpeed = self.windSpeed {
            if let windDirection = self.windDirection {
                return "\(NSNumberFormatter.localizedStringFromNumber(windSpeed, numberStyle: .DecimalStyle)) km/h, \(NSNumberFormatter.localizedStringFromNumber(windDirection, numberStyle: .DecimalStyle))º"
            }
        }
        
        return nil
    }
    
    func formattedPressureAndPressureTrend() -> String? {
        if let pressure = self.pressure {
            if let pressureTrend = self.pressureTrend {
                return "\(NSNumberFormatter.localizedStringFromNumber(pressure, numberStyle: .DecimalStyle)) kPa, \(pressureTrend)"
            }
        }
        
        return nil
    }
    
    func formattedRadiation() -> String? {
        if let radiation = self.radiation {
            return "\(NSNumberFormatter.localizedStringFromNumber(radiation, numberStyle: .DecimalStyle)) W/m²"
        }
        
        return nil
    }
    
    func formattedWeatherConditions() -> [(name: String, value: String)] {
        var formattedWeatherConditions: [(name: String, value: String)] = []
        
        if let formattedTemperature = self.formattedTemperature() {
            formattedWeatherConditions.append(name: "Temperature", value: formattedTemperature)
        }
        
        if let formattedHumidex = self.formattedHumidex() {
            formattedWeatherConditions.append(name: "Humidex", value: formattedHumidex)
        }
        
        if let formattedWindChill = self.formattedWindChill() {
            formattedWeatherConditions.append(name: "Windchill", value: formattedWindChill)
        }
        
        if let formattedRelativeHumidity = self.formattedRelativeHumidity() {
            formattedWeatherConditions.append(name: "Relative Humidity", value: formattedRelativeHumidity)
        }
        
        if let formattedDewPoint = self.formattedDewPoint() {
            formattedWeatherConditions.append(name: "Dew Point", value: formattedDewPoint)
        }
        
        if let formattedWindSpeedAndDirection = self.formattedWindSpeedAndDirection() {
            formattedWeatherConditions.append(name: "Wind Speed", value: formattedWindSpeedAndDirection)
        }
        
        if let formattedPressureAndPressureTrend = self.formattedPressureAndPressureTrend() {
            formattedWeatherConditions.append(name: "Pressure", value: formattedPressureAndPressureTrend)
        }
        
        if let formattedRadiation = self.formattedRadiation() {
            formattedWeatherConditions.append(name: "Incoming Radiation", value: formattedRadiation)
        }
        
        return formattedWeatherConditions
    }
}
