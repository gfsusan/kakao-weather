//
//  HourlyCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class HourlyCell: UITableViewCell {
    
    var hourlyViewModel: HourlyWeatherViewModel? {
        didSet {
            collectionView.hourlyViewModel = hourlyViewModel
        }
    }
    
    let collectionView: HourlyCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = HourlyCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        collectionView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
   
}
