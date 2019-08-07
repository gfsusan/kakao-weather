//
//  SummaryCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    var summaryViewModel: SummaryViewModel? {
        didSet {
            summaryLabel.text = summaryViewModel?.summary
        }
    }
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(summaryLabel)
        summaryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
