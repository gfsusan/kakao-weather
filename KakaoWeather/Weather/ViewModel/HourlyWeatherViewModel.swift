//
//  HourlyWeatherViewModel.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

struct HourlyWeatherViewModel {
    let hourlyWeathers: [HourlyWeather]
    
    init(forecast: Forecast) {
        guard let hourly = forecast.hourly else {
            hourlyWeathers = []
            return
        }
        
        var hourlyData = [HourlyWeather]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hha"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        hourly.points.forEach { (point) in
            var time = dateFormatter.string(from: point.time)
            if time == dateFormatter.string(from: Date()) {
                time = "NOW"
            }
            
            let icon = point.icon ?? ""
            let temperature: String
            if let temp = point.temperature?.current {
                temperature = "\(Int(temp))°"
            } else {
                temperature = " -- °"
            }
            let weather = HourlyWeather(time: time, icon: icon, temperature: temperature)
            hourlyData.append(weather)
        }
        
        self.hourlyWeathers = hourlyData
    }
}

struct HourlyWeather {
    let time: String
    let icon: String
    let temperature: String
}
