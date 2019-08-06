//
//  APIService.swift
//  KakaoWeather
//
//  Created by Susan Kim on 06/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    let baseUrl = "https://api.darksky.net/forecast/"
    private let key = "1ec87ac3261a96f1ded35f8fd1d18a5e"
    
    private init() {
        
    }
    
    func fetchForecast(latitude: Double, longtitude: Double, completion: @escaping((Result<String, APIError>) -> ())) {
        let urlString = "\(baseUrl)\(key)/\(latitude),\(longtitude)?exclude=alerts,flags"
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

enum APIError: Error {
    case urlError
}
