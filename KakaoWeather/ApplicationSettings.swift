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
        static let coordinates = "com.suzenyada.coordinates"
    }
    
    struct Status {
        
        static var coordinates: Set<Coordinate> = {
            guard let fetchedData = UserDefaults.standard.data(forKey: Config.coordinates) else {
                return []
            }
            guard let coordinates = try? PropertyListDecoder().decode(Set<Coordinate>.self, from: fetchedData) else { return [] }
            
            return coordinates
        }()
        {
            didSet {
                guard let coordinatesData = try? PropertyListEncoder().encode(coordinates) else { return }
                UserDefaults.standard.set(coordinatesData, forKey: Config.coordinates)
            }
        }
        
    }
}

struct Coordinate: Codable, Hashable {
    var longtitude: Double
    var latitude: Double
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.longtitude == rhs.longtitude && lhs.latitude == rhs.latitude
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(longtitude)
        hasher.combine(latitude)
    }
}
