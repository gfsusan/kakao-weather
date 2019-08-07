//
//  DetailCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    var detailViewModel: DetailWeatherViewModel? {
        didSet {
            updateView()
        }
    }
    
    let contentViews: [DetailContentView] = {
        var views = [DetailContentView]()
        (1...10).forEach({ _ in
            views.append(DetailContentView())
        })
        
        return views
    }()
    
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
        
        (0...4).enumerated().forEach { index, _ in
            let hStackView = UIStackView(arrangedSubviews: [contentViews[index * 2], contentViews[index * 2 + 1]])
            hStackView.axis = .horizontal
            hStackView.spacing = 16
            hStackView.distribution = .fillEqually
            hStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true

            stackView.addArrangedSubview(hStackView)
        }
    }
    
    func updateView() {
        let titles = [
            "SUNRISE",
            "SUNSET",
            "CHANCE OF RAIN",
            "HUMIDITY",
            "WIND",
            "FEELS LIKE",
            "PRECIPITATION",
            "PRESSURE",
            "VISIBILITY",
            "UV INDEX"
        ]
        
        guard let m = detailViewModel else { return }
        let values = [
            m.sunrise,
            m.sunset,
            m.chanceOfRain,
            m.humidity,
            m.wind,
            m.feelsLike,
            m.precipitation,
            m.pressure,
            m.visibility,
            m.uvIndex
        ]
        
        contentViews.enumerated().forEach { (index, view) in
            view.title = titles[index]
            view.value = values[index]
        }
    }
}

class DetailContentView: UIView {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
