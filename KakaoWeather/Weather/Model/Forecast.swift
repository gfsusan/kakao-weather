//
//  Forecast.swift
//  KakaoWeather
//
//  Created by Susan Kim on 06/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import CoreLocation

struct Forecast {
    
    let location: CLLocation?
    let timezone: TimeZone?
    let current: DataPoint?
//    let minutely: DataBlock?
    let hourly: DataBlock?
    let daily: DataBlock?
    
    
    init(json: Dictionary<String, Any>) {
        
        if let latitude = json["latitude"] as? CLLocationDegrees,
            let longtitude = json["longitude"] as? CLLocationDegrees {
            location = CLLocation(latitude: latitude, longitude: longtitude)
        } else {
            location = nil
        }
        
        if let zone = json["timezone"] as? String {
            timezone = TimeZone(identifier: zone)
        } else {
            timezone = nil
        }

        if let currentData = json["currently"] as? Dictionary<String, Any> {
            current = DataPoint(json: currentData)
        } else {
            current = nil
        }
        
        if let hourlyData = json["hourly"] as? Dictionary<String, Any> {
            hourly = DataBlock(json: hourlyData)
        } else {
            hourly = nil
        }
        
        if let dailyData = json["daily"] as? Dictionary<String, Any> {
            daily = DataBlock(json: dailyData)
        } else {
            daily = nil
        }
        
    }
}
