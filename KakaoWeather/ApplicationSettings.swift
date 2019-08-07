//
//  ApplicationSettings.swift
//  KakaoWeather
//
//  Created by Susan Kim on 06/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ApplicationSettings {
    struct Config {
        static let locations = "com.suzenyada.locations"
    }
    
    struct Status {
        
        static var locations: Set<Location> = {
            guard let fetchedData = UserDefaults.standard.data(forKey: Config.locations) else {
                return []
            }
            guard let coordinates = try? PropertyListDecoder().decode(Set<Location>.self, from: fetchedData) else { return [] }
            
            return coordinates
        }()
        {
            didSet {
                guard let coordinatesData = try? PropertyListEncoder().encode(locations) else { return }
                UserDefaults.standard.set(coordinatesData, forKey: Config.locations)
            }
        }
        
    }
}
