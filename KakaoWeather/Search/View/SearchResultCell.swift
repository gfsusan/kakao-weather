//
//  SearchResultCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 06/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
