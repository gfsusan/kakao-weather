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
    
    func fetchForecast(latitude: Double, longtitude: Double, completion: @escaping((Result<Forecast, APIError>) -> ())) {
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
                    if let jsonDict = json as? Dictionary<String, Any> {
                        let forecast = Forecast(json: jsonDict)
                        completion(.success(forecast))
                    } else {
                        completion(.failure(.parseFailure))
                    }
                } catch {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
}

enum APIError: Error {
    case urlError
    case parseFailure
    case noData
}
