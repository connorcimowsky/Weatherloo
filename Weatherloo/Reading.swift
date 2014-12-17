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

extension Reading {
    func formattedObservationTime() -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = self.observationTimeZone
        dateFormatter.dateStyle = .NoStyle;
        dateFormatter.timeStyle = .ShortStyle;
        
        if let observationTime = self.observationTime {
            return "Current Reading: \(dateFormatter.stringFromDate(observationTime))"
        }
        
        return nil
    }
    
    func formattedTemperature() -> String? {
        if let temperature = self.temperature {
            return "Temperature: \(NSNumberFormatter.localizedStringFromNumber(temperature, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedHumidex() -> String? {
        if let humidex = self.humidex {
            return "Humidex: \(NSNumberFormatter.localizedStringFromNumber(humidex, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedWindChill() -> String? {
        if let windChill = self.windChill {
            return "Windchill: \(NSNumberFormatter.localizedStringFromNumber(windChill, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedRelativeHumidity() -> String? {
        if let relativeHumidity = self.relativeHumidity {
            return "Relative Humidity: \(NSNumberFormatter.localizedStringFromNumber(relativeHumidity, numberStyle: .DecimalStyle))%"
        }
        
        return nil
    }
    
    func formattedDewPoint() -> String? {
        if let dewPoint = self.dewPoint {
            return "Dew Point: \(NSNumberFormatter.localizedStringFromNumber(dewPoint, numberStyle: .DecimalStyle)) ºC"
        }
        
        return nil
    }
    
    func formattedWindSpeedAndDirection() -> String? {
        if let windSpeed = self.windSpeed {
            if let windDirection = self.windDirection {
                return "Wind Speed: \(NSNumberFormatter.localizedStringFromNumber(windSpeed, numberStyle: .DecimalStyle)) km/h, \(NSNumberFormatter.localizedStringFromNumber(windDirection, numberStyle: .DecimalStyle))º"
            }
        }
        
        return nil
    }
    
    func formattedPressureAndPressureTrend() -> String? {
        if let pressure = self.pressure {
            if let pressureTrend = self.pressureTrend {
                return "Pressure: \(NSNumberFormatter.localizedStringFromNumber(pressure, numberStyle: .DecimalStyle)) kPa, \(pressureTrend)"
            }
        }
        
        return nil
    }
    
    func formattedRadiation() -> String? {
        if let radiation = self.radiation {
            return "Incoming Radiation: \(NSNumberFormatter.localizedStringFromNumber(radiation, numberStyle: .DecimalStyle)) W/m²"
        }
        
        return nil
    }
    
    func formattedWeatherConditions() -> [String] {
        var formattedWeatherConditions: [String] = []
        
        if let formattedTemperature = self.formattedTemperature() {
            formattedWeatherConditions.append(formattedTemperature)
        }
        
        if let formattedHumidex = self.formattedHumidex() {
            formattedWeatherConditions.append(formattedHumidex)
        }
        
        if let formattedWindChill = self.formattedWindChill() {
            formattedWeatherConditions.append(formattedWindChill)
        }
        
        if let formattedRelativeHumidity = self.formattedRelativeHumidity() {
            formattedWeatherConditions.append(formattedRelativeHumidity)
        }
        
        if let formattedDewPoint = self.formattedDewPoint() {
            formattedWeatherConditions.append(formattedDewPoint)
        }
        
        if let formattedWindSpeedAndDirection = self.formattedWindSpeedAndDirection() {
            formattedWeatherConditions.append(formattedWindSpeedAndDirection)
        }
        
        if let formattedPressureAndPressureTrend = self.formattedPressureAndPressureTrend() {
            formattedWeatherConditions.append(formattedPressureAndPressureTrend)
        }
        
        if let formattedRadiation = self.formattedRadiation() {
            formattedWeatherConditions.append(formattedRadiation)
        }
        
        if let formattedTemperature = self.formattedTemperature() {
            formattedWeatherConditions.append(formattedTemperature)
        }
        
        return formattedWeatherConditions
    }
}
