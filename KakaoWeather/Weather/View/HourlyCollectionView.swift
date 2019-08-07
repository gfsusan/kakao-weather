//
//  HourlyCollectionView.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class HourlyCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    var hourlyViewModel: HourlyWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        delegate = self
        dataSource = self
        
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        backgroundColor = .white
        register(HourlyDetailCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyViewModel?.hourlyWeathers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? HourlyDetailCell else { return UICollectionViewCell() }
        
        let hourlyDetail = hourlyViewModel?.hourlyWeathers[indexPath.row]
        cell.viewModel = hourlyDetail
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 120)
    }
    
}

class HourlyDetailCell: UICollectionViewCell {
    
    var viewModel: HourlyWeather? {
        didSet {
            timeLabel.text = viewModel?.time
            iconLabel.text = viewModel?.icon
            temperatureLabel.text = viewModel?.temperature
        }
    }
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, iconLabel, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        iconLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
