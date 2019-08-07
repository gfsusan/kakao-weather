//
//  WeatherController.swift
//  KakaoWeather
//
//  Created by Susan Kim on 03/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class WeatherController: ViewController {
    
    var delegate: WeatherControllerDelegate?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var hamburgerButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "side_menu"), style: .plain, target: self, action: #selector(handleSideMenuToggle))
        return button
    }()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        return button
    }()
    
    lazy var tempButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(handleTest))
        return button
    }()
    
    @objc func handleTest() {
        let tempLocation = Location(name: "SEEOOOOOOUULL", latitude: 21.2, longtitude: 45)
        APIService.shared.fetchForecast(location: tempLocation) { (result) in
            switch result {
                
            case .success(let forecast):
                print(forecast)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func configureConstraints() {
        navigationItem.leftBarButtonItem = hamburgerButton
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func handleSideMenuToggle() {
        delegate?.handleSideMenuToggle(forLocation: nil)
    }
    
    @objc func handleAdd() {
        let searchVC = SearchCityController()
        let searchNavContr = UINavigationController(rootViewController: searchVC)
        self.present(searchNavContr, animated: true)
    }

}

extension WeatherController: UICollectionViewDelegate, UICollectionViewDataSource {

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        collectionView.register(WeatherDetailCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInsetAdjustmentBehavior = .never
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ApplicationSettings.Status.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? WeatherDetailCell else { return UICollectionViewCell() }
        
        let locations = Array(ApplicationSettings.Status.locations)
        let location = locations[indexPath.row]
        
        APIService.shared.fetchForecast(location: location) { (result) in
            switch result {
                
            case .success(let forecast):
                // update cell
                print("Forecast data for location \(location): \(forecast)")
            case .failure(_):
                // stop
                print("Failed to fetch weather data")
            }
        }
        
        return cell
    }
}

extension WeatherController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
