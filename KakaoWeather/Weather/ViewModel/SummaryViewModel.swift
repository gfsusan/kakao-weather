//
//  SummaryViewModel.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

struct SummaryViewModel {
    let summary: String
    
    init(forecast: Forecast) {
        if let summary = forecast.daily?.points.first?.summary {
            self.summary = "Today: \(summary)"
        } else {
            self.summary = ""
        }
    }
}
