//
//  DailyCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    
    var dailyViewModel: DailyWeatherViewModel? {
        didSet {
            updateView()
            print(dailyViewModel)
        }
    }
    
    let stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func updateView() {
        stackView.arrangedSubviews.forEach { (v) in
            v.removeFromSuperview()
        }
        
        dailyViewModel?.dailyWeathers.forEach({ (weather) in
            let dayLabel = UILabel()
            dayLabel.font = .systemFont(ofSize: 19, weight: .light)
            dayLabel.text = weather.day
            
            let iconLabel = UILabel()
            iconLabel.font = .systemFont(ofSize: 14, weight: .light)
            iconLabel.adjustsFontSizeToFitWidth = true
            iconLabel.text = weather.icon
            
            let maxTempLabel = UILabel()
            maxTempLabel.font = .systemFont(ofSize: 20, weight: .light)
            maxTempLabel.text = weather.maxTemperature
            
            let minTempLabel = UILabel()
            minTempLabel.font = .systemFont(ofSize: 20, weight: .light)
            minTempLabel.textColor = .gray
            minTempLabel.text = weather.minTemperature
            
            let view = UIStackView(arrangedSubviews: [dayLabel, iconLabel, maxTempLabel, minTempLabel])
            view.spacing = 8
            view.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            dayLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
            maxTempLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
            minTempLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
            
            stackView.addArrangedSubview(view)
        })
    }
}
