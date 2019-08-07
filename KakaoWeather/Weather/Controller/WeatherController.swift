//
//  WeatherController.swift
//  KakaoWeather
//
//  Created by Susan Kim on 03/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class WeatherController: ViewController {
    
    var delegate: WeatherControllerDelegate?
    
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
    }
    
    override func configureConstraints() {
        navigationItem.leftBarButtonItem = hamburgerButton
//        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItems = [addButton, tempButton]
    }
    
    @objc func handleSideMenuToggle() {
        delegate?.handleSideMenuToggle(forMenuOption: nil)
    }
    
    @objc func handleAdd() {
        let searchVC = SearchCityController()
        let searchNavContr = UINavigationController(rootViewController: searchVC)
        self.present(searchNavContr, animated: true)
    }
}
