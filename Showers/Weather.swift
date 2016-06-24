//
//  Weather.swift
//  Showers
//
//  Created by Abhishek Dwivedi on 15/05/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

/*
Weather is a Model for the weather data.
*/

import Foundation

struct Weather {

    var weatherDescription: String?
    var weatherIcon: String?
    var temperature: Double?
    
    var temperatureDictionary: [String:AnyObject]?
    
    init(weatherDict: [String: AnyObject]) {
        temperatureDictionary = weatherDict["temperature"] as? Dictionary
        self.temperature = temperatureDictionary!["temp"] as? Double
        self.weatherIcon = ""
        self.weatherDescription = ""
    }
}