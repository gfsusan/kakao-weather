//
//  DetailWeatherViewModel.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

struct DetailWeatherViewModel {
    let sunrise: String
    let sunset: String
    let chanceOfRain: String
    let humidity: String
    let wind: String
    let feelsLike: String
    let precipitation: String
    let pressure: String
    let visibility: String
    let uvIndex: String
    
    init(forecast: Forecast) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        // current
        if let current = forecast.current {
            if let prob = current.precipitation?.probability {
                self.chanceOfRain = "\(Int(prob * 100))%"
            } else {
                self.chanceOfRain = "-- %"
            }
            
            if let humidity = current.humidity {
                self.humidity = "\(Int(humidity * 100))%"
            } else {
                self.humidity = "-- %"
            }
            
            if let bearing = current.wind?.bearing, let speed = current.wind?.speed {
                self.wind = "\(bearing) \(speed) m/s"
            } else {
                self.wind = "-- -- m/s"
            }
            
            if let intensity = current.precipitation?.intensity {
                let roundedIntensity = Double(round(intensity*10)/10)
                self.precipitation = "\(roundedIntensity) mm"
            } else {
                self.precipitation = "-- mm"
            }
            
            if let press = current.pressure {
                self.pressure = "\(Int(press)) hPa"
            } else {
                self.pressure = "--- hPa"
            }
            
            if let visibility = current.visibility {
                let roundedVisibility = Double(round(visibility*10)/10)
                self.visibility = "\(roundedVisibility) km"
            } else {
                self.visibility = "-- km"
            }
            
            if let uv = current.uvIndex {
                self.uvIndex = "\(uv)"
            } else {
                self.uvIndex = "--"
            }
        } else {
            self.chanceOfRain = ""
            self.humidity = ""
            self.wind = ""
            self.precipitation = ""
            self.pressure = ""
            self.visibility = ""
            self.uvIndex = ""
        }
        
        // hourly
        if let hourly = forecast.hourly {
            if let apparentTemp = hourly.points.first?.apparentTemperature?.current {
                self.feelsLike = "\(apparentTemp)°"
            } else {
                self.feelsLike = "-- °"
            }
        } else {
            self.feelsLike = ""
        }
        
        // daily
        if let daily = forecast.daily {
            if let rise = daily.points.first?.sunrise {
                self.sunrise = dateFormatter.string(from: rise)
            } else {
                self.sunrise = "--:-- --"
            }
            
            if let set = daily.points.first?.sunset {
                self.sunset = dateFormatter.string(from: set)
            } else {
                self.sunset = "--:-- --"
            }
        } else {
            self.sunrise = ""
            self.sunset = ""
        }
    }
}
