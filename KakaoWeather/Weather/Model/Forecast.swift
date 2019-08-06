//
//  Forecast.swift
//  KakaoWeather
//
//  Created by Susan Kim on 06/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation
import CoreLocation

typealias DataBlock = [String: Any]
typealias DataPoint = [String: Any]

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

        current = json["currently"] as? Dictionary<String, Any> ?? nil
        hourly = json["hourly"] as? Dictionary<String, Any> ?? nil
        daily = json["daily"] as? Dictionary<String, Any> ?? nil
        
    }
}
