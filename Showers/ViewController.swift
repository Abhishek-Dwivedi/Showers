//
//  ViewController.swift
//  Showers
//
//  Created by Abhishek Dwivedi on 15/05/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    @IBOutlet weak var weatherIconImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Call fetchCurrentWeather() of WeatherService which returns the weather model object
        let weatherService = WeatherService()
        weatherService.fetchCurrentWeather() {
            (let weather) in
            if let currentWeather = weather {
                //Async call for updating the UI
                dispatch_async(dispatch_get_main_queue()) {
                    guard let temp = currentWeather.temperature
                        else {
                            return
                    }
                    print(temp)
                    self.temperatureLabel.text = "\(temp)"
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}