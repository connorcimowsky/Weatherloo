//
//  ReadingTests.swift
//  Weatherloo
//
//  Created by Connor Cimowsky on 12/16/14.
//  Copyright (c) 2014 Connor Cimowsky. All rights reserved.
//

import XCTest
import WeatherlooData

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
        XCTAssertEqual("2014-12-16T15:45:13-05:00", reading!.timestamp!, "Timestamp should be set correctly.")
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
}
