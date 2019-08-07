//
//  DaliyWeatherViewModel.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

struct DailyWeatherViewModel {
    let dailyWeathers: [DailyWeather]
    
    init(forecast: Forecast) {
        guard let daily = forecast.daily else {
            dailyWeathers = []
            return
        }
        
        var weathers = [DailyWeather]()
        
        daily.points.forEach { (point) in
            let calendar = Calendar.current
            let dayComponent = calendar.component(.weekday, from: point.time)
            let day = days[dayComponent]
            
            let icon = point.icon ?? ""
            
            let max: String
            if let temp = point.temperature?.max {
                max = "\(Int(temp))°"
            } else {
                max = " -- °"
            }
            
            let min: String
            if let temp = point.temperature?.min {
                min = "\(Int(temp))°"
            } else {
                min = " -- °"
            }
            
            weathers.append(DailyWeather(day: day, icon: icon, maxTemperature: max, minTemperature: min))
        }
        
        dailyWeathers = weathers
    }
}

struct DailyWeather {
    let day: String
    let icon: String
    let maxTemperature: String
    let minTemperature: String
}
