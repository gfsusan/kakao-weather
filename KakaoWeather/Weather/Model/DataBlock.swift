//
//  DataBlock.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

struct DataBlock {
    let points: [DataPoint]
    let summary: String?
    let icon: String?
    
    init(json: Dictionary<String, Any>) {
        if let array = json["data"] as? [Dictionary<String,Any>] {
        
            var dataPoints : [DataPoint] = []
            for dict in array {
                dataPoints.append(DataPoint(json: dict))
            }
            self.points = dataPoints
            } else {
            points = []
            
        }
            self.summary = json["summary"] as? String
            self.icon = json["icon"] as? String
    }
}
