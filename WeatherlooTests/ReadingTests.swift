//
//  ReadingTests.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/16/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import XCTest

class ReadingTests: XCTestCase {
    var reading: Reading?
    
    override func setUp() {
        super.setUp()
        
        let fixturePath = NSBundle(forClass: ReadingTests.self).pathForResource("Reading-Fixture", ofType: "json")
        let fixtureData = NSData(contentsOfFile: fixturePath!)
        let fixtureDictionary = NSJSONSerialization.JSONObjectWithData(fixtureData!, options: .MutableContainers, error: nil) as? NSDictionary
        
        reading = Reading(responseDictionary: fixtureDictionary!)
    }
    
    func test_timeIsPopulated() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit, fromDate: reading!.observationTime!)
        
        XCTAssertEqual(components.year, 2014, "Year should be set correctly.")
        XCTAssertEqual(components.month, 12, "Month should be set correctly.")
        XCTAssertEqual(components.day, 16, "Day should be set correctly.")
        XCTAssertEqual(components.hour, 15, "Hour should be set correctly.")
        XCTAssertEqual(components.minute, 45, "Minute should be set correctly.")
        XCTAssertEqual(components.second, 13, "Second should be set correctly.")
        
        XCTAssertEqual(reading!.observationTimeZone!, NSTimeZone(name: "GMT-05:00")!, "Time zone should be set correctly.")
    }
    
    func test_temperatureIsPopulated() {
        XCTAssertEqual(3.2, reading!.temperature!, "Temperature should be set correctly.")
    }
    
    func test_humidexIsPopulated() {
        XCTAssertEqual(2.6, reading!.humidex!, "Humidex should be set correctly.")
    }
    
    func test_windChillIsPopulated() {
        XCTAssertEqual(-1.3, reading!.windChill!, "Windchill should be set correctly.")
    }
    
    func test_relativeHumidityIsPopulated() {
        XCTAssertEqual(98.9, reading!.relativeHumidity!, "Relative humidity should be set correctly.")
    }
    
    func test_dewPointIsPopulated() {
        XCTAssertEqual(2.3, reading!.dewPoint!, "Dew point should be set correctly.")
    }
    
    func test_windSpeedIsPopulated() {
        XCTAssertEqual(28, reading!.windSpeed!, "Wind speed should be set correctly.")
    }
    
    func test_windDirectionIsPopulated() {
        XCTAssertEqual(225, reading!.windDirection!, "Wind direction should be set correctly.")
    }
    
    func test_pressureIsPopulated() {
        XCTAssertEqual(100.6, reading!.pressure!, "Pressure should be set correctly.")
    }
    
    func test_pressureTrendIsPopulated() {
        XCTAssertEqual("Falling", reading!.pressureTrend!, "Pressure trend should be set correctly.")
    }
    
    func test_radiationIsPopulated() {
        XCTAssertEqual(13.6, reading!.radiation!, "Incoming solar radiation should be set correctly.")
    }
    
    func test_timeIsFormattedCorrectly() {
        XCTAssertEqual("3:45 PM", reading!.formattedObservationTime()!, "Time should be formatted correctly.")
    }
    
    func test_temperatureIsFormattedCorrectly() {
        XCTAssertEqual("3.2 ºC", reading!.formattedTemperature()!, "Temperature should be formatted correctly.")
    }
    
    func test_humidexIsFormattedCorrectly() {
        XCTAssertEqual("2.6 ºC", reading!.formattedHumidex()!, "Humidex should be formatted correctly.")
    }
    
    func test_windChillIsFormattedCorrectly() {
        XCTAssertEqual("-1.3 ºC", reading!.formattedWindChill()!, "Windchill should be formatted correctly.")
    }
    
    func test_relativeHumidityIsFormattedCorrectly() {
        XCTAssertEqual("98.9%", reading!.formattedRelativeHumidity()!, "Relative humidity should be formatted correctly.")
    }
    
    func test_dewPointIsFormattedCorrectly() {
        XCTAssertEqual("2.3 ºC", reading!.formattedDewPoint()!, "Dew point should be formatted correctly.")
    }
    
    func test_windIsFormattedCorrectly() {
        XCTAssertEqual("28 km/h, 225º", reading!.formattedWindSpeedAndDirection()!, "Wind speed and direction should be formatted correctly.")
    }
    
    func test_pressureIsFormattedCorrectly() {
        XCTAssertEqual("100.6 kPa, Falling", reading!.formattedPressureAndPressureTrend()!, "Pressure and pressure trend should be formatted correctly.")
    }
    
    func test_radiationIsFormattedCorrectly() {
        XCTAssertEqual("13.6 W/m²", reading!.formattedRadiation()!, "Incoming solar radiation should be formatted correctly.")
    }
}
