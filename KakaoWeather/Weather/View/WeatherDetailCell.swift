//
//  WeatherDetailCell.swift
//  KakaoWeather
//
//  Created by Susan Kim on 07/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

private let cellIds = ["currentCellId", "hourlyCellId", "dailyCellId", "summaryCellId", "detailCellId"]

class WeatherDetailCell: UICollectionViewCell {
    
    var forecast: Forecast? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var location: Location? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTableView()
        configureConstraints()
    }
    
    func configureConstraints() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherDetailCell: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
                
        cellIds.forEach { (id) in
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
        }
        
        tableView.register(CurrentCell.self, forCellReuseIdentifier: cellIds[0])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = cellIds[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CurrentCell else {
                return UITableViewCell()
            }
            
            if let forecast = forecast, let location = location {
                cell.currentViewModel = CurrentWeatherViewModel(location: location, forecast: forecast)
            }
            
            return cell
            
        default:
            return cell
        }
    }
    
    
}
