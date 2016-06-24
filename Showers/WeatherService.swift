//
//  WeatherService.swift
//  Showers
//
//  Created by Abhishek Dwivedi on 15/05/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import Foundation

/*
WeatherService constructs the URL and parse the data given by the NetworkOperator and returns Weather model object.
*/

struct WeatherService {
    
    private let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let APIkey = "c2723d669392f533d11bae3b985740a9"
    private let bangaloreCountryCode = "1277333"
    private let unitInCelcius = "metric"
    let weatherURL: NSURL?
    
    //Constructs the URL
    init() {
        let weatherURLComponent = NSURLComponents(string: baseURL)
        let queryItem1 = NSURLQueryItem(name: "id", value: bangaloreCountryCode)
        let queryItem2 = NSURLQueryItem(name: "appid", value: APIkey)
        let queryItem3 = NSURLQueryItem(name: "units", value: unitInCelcius)
        weatherURLComponent?.queryItems = [queryItem1,queryItem2,queryItem3]
        weatherURL = weatherURLComponent?.URL
    }
    
    //Fetches the weather data and returns the Weather model object to the ViewController
    func fetchCurrentWeather(completion: Weather? -> Void) {
        //Passes the URL to Network Operator, gets the NSData,
        let networkOperator = NetworkOperator(url: weatherURL!)
        //Call the downloadDataFromURL() of NetworkOperator
        networkOperator.downloadDataFromURL {
            (let jsonDictionary) in
            let weather = self.parseWeatherFromJSON(jsonDictionary)
            print(weather!)
            completion(weather)
        }
    }
    
    //Parses the NSData to Weather model object and returns it to the fetchCurrentWeather()
    func parseWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> Weather? {
        var weatherDict = [String: AnyObject]()
        guard let  temperatureData = jsonDictionary?["main"]
            else {
                print("Json Dictionary returned nil for the key weather")
                return nil
        }
        weatherDict["temperature"] = temperatureData
        return Weather(weatherDict: weatherDict)
        }
    }