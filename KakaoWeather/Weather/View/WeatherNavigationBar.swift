//
//  WeatherNavigationBar.swift
//  KakaoWeather
//
//  Created by Susan Kim on 03/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class WeatherNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set navigation bar and shadow transparent
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        backgroundColor = .clear
        isTranslucent = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
