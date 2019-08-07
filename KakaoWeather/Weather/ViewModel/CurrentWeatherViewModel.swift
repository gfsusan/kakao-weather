//
//  CurrentWeatherViewModel.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

let days = ["", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

struct CurrentWeatherViewModel {
    let city: String
    let summary: String
    let temperature: String
    let day: String
    let maxTemperature: String
    let minTemperature: String
    
    init(location: Location, forecast: Forecast) {
        city = location.name
        summary = forecast.current?.summary ??  ""
        if let temp = forecast.current?.temperature?.current {
            temperature = "\(temp)°"
        } else {
            temperature = " -- °"
        }
        
        if let date = forecast.current?.time {
            let calendar = Calendar.current
            let dayComponent = calendar.component(.weekday, from: date)
            day = days[dayComponent]
        } else {
            day = ""
        }
        
        if let maxTemp = forecast.daily?.points.first?.temperature?.max {
            maxTemperature = "\(maxTemp)°"
        } else {
            maxTemperature = " -- °"
        }
        
        if let minTemp = forecast.daily?.points.first?.temperature?.min {
            minTemperature = "\(minTemp)°"
        } else {
            minTemperature = " -- °"
        }
    }
}
