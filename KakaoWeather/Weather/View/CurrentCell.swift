//
//  CurrentCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class CurrentCell: UITableViewCell {
    
    var currentViewModel: CurrentWeatherViewModel? {
        didSet {
            cityLabel.text = currentViewModel?.city
            summaryLabel.text = currentViewModel?.summary
            temperatureLabel.text = currentViewModel?.temperature
            weekdayLabel.text = currentViewModel?.day
            maxTempLabel.text = currentViewModel?.maxTemperature
            minTempLabel.text = currentViewModel?.minTemperature
        }
    }
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 80, weight: .light)
        return label
    }()
    
    let weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "TODAY"
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        let stackView = UIStackView(arrangedSubviews: [cityLabel, summaryLabel, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
        
        let todayTempStackView = UIStackView(arrangedSubviews: [weekdayLabel, todayLabel, UIView(), maxTempLabel, minTempLabel])
        todayTempStackView.translatesAutoresizingMaskIntoConstraints = false
        todayTempStackView.axis = .horizontal
        todayTempStackView.distribution = .fill
        todayTempStackView.alignment = .center
        todayTempStackView.spacing = 16
        
        addSubview(todayTempStackView)
        todayTempStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        todayTempStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        todayTempStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        todayTempStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true    }
}
