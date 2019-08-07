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
        tableView.register(HourlyCell.self, forCellReuseIdentifier: cellIds[1])
        tableView.register(DailyCell.self, forCellReuseIdentifier: cellIds[2])
        tableView.register(SummaryCell.self, forCellReuseIdentifier: cellIds[3])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = cellIds[indexPath.row]
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CurrentCell else { return defaultCell }
            
            if let forecast = forecast, let location = location {
                cell.currentViewModel = CurrentWeatherViewModel(location: location, forecast: forecast)
            }
            
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HourlyCell else { return defaultCell }
            
            if let forecast = forecast {
                cell.hourlyViewModel = HourlyWeatherViewModel(forecast: forecast)
            }
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DailyCell else { return defaultCell }
            
            if let forecast = forecast {
                cell.dailyViewModel = DailyWeatherViewModel(forecast: forecast)
            }
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SummaryCell else { return defaultCell}
            
            if let forecast = forecast {
                cell.summaryViewModel = SummaryViewModel(forecast: forecast)
            }
            
            return cell
        default:
            return defaultCell
        }
    }
    
    
}
