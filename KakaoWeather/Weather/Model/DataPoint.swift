//
//  DataPoint.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

typealias Pressure = Double
typealias Humidity = Double
typealias Visibility = Double

struct DataPoint {
    
    let time: Date
    let temperature: Temperature?
    let pressure: Pressure?
    let visibility: Visibility?
    let sunrise: Date?
    let sunset: Date?
    let precipitation: Precipitation?
    let humidity: Humidity?
    let wind: Wind?
    let apparentTemperature: Temperature?
    let uvIndex: Int?
    let summary: String?
    
    init(json: Dictionary<String, Any>) {
        let timestamp = json["time"] as? Double ?? 0
        self.time = Date(timeIntervalSince1970: timestamp)
        
        let temperatureCurrent = json["temperature"] as? Double ?? 0
        let temperatureMax = json["temperatureMax"] as? Double ?? 0
        let temperatureMin = json["temperatureMin"] as? Double ?? 0
        
        self.temperature = Temperature(current: temperatureCurrent, max: temperatureMax, min: temperatureMin)
        
        self.pressure = json["pressure"] as? Double
        self.visibility = json["visibility"] as? Double
        
        if let sunriseTime = json["sunriseTime"] as? Double {
            self.sunrise = Date(timeIntervalSince1970: sunriseTime)
        } else {
            self.sunrise = nil
        }
        
        if let sunsetTime = json["sunsetTime"] as? Double {
            self.sunset = Date(timeIntervalSince1970: sunsetTime)
        } else {
            self.sunset = nil
        }
        
        if let precipIntensity = json["precipIntensity"] as? Double,
            let precipProbability = json["precipProbability"] as? Double {
            
            self.precipitation = Precipitation(
                type: PrecipitationType(rawValue: json["precipType"] as? String ?? "") ?? nil,
                intensity: precipIntensity,
                probability: precipProbability)
        } else {
            self.precipitation = nil
        }
        
        self.humidity = json["humidity"] as? Double ?? nil
        
        if let windBearing = json["windBearing"] as? Double,
            let windSpeed = json["windSpeed"] as? Double {
            self.wind = Wind(bearing: windBearing,
                             speed: windSpeed)
        } else {
            self.wind = nil
        }
        
        if let apparentTemperatureCurrent = json["apparentTemperature"] as? Double,
            let apparentTemperatureMax = json["apparentTemperatureMax"] as? Double,
            let apparentTemperatureMin = json["apparentTemperatureMin"] as? Double {
            
            self.apparentTemperature = Temperature(current: apparentTemperatureCurrent, max: apparentTemperatureMax, min: apparentTemperatureMin)
        } else {
            self.apparentTemperature = nil
        }
        
        self.uvIndex = json["uvIndex"] as? Int
        self.summary = json["summary"] as? String

    }
}
