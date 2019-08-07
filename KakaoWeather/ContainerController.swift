//
//  ContainerController.swift
//  KakaoWeather
//
//  Created by Susan Kim on 03/08/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    var weatherNavigationController: UIViewController!
    var isExpanded: Bool = false
    
    let sideMenuController = SideMenuController()
    let weatherController = WeatherController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeatherController()
        setupSideMenuController()
    }
    
    func setupSideMenuController() {
        sideMenuController.delegate = self
        view.insertSubview(sideMenuController.view, at: 0)
        addChild(sideMenuController)
        sideMenuController.didMove(toParent: self)
    }
    
    func setupWeatherController() {
        weatherController.delegate = self
        weatherNavigationController = UINavigationController(rootViewController: weatherController)
        
        view.addSubview(weatherNavigationController.view)
        addChild(weatherNavigationController)
        weatherNavigationController.didMove(toParent: self)
    }
    
    func animateSideMenuController(shouldExpand: Bool, location: Location?) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.weatherNavigationController.view.frame.origin.x = self.weatherNavigationController.view.frame.width - 100
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.weatherNavigationController.view.frame.origin.x = 0
            }, completion: { _ in
                if let location = location {
                    self.handleLocationSelection(forLocation: location)
                }
            })
        }
    }
    
    func handleLocationSelection(forLocation location: Location) {
        let locations = Array(ApplicationSettings.Status.locations)
        if let itemIndex = locations.firstIndex(of: location) {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            weatherController.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
}

extension ContainerController: WeatherControllerDelegate {
    func handleSideMenuToggle(forLocation location: Location?) {
        sideMenuController.tableView.reloadData()
        
        isExpanded = !isExpanded
        animateSideMenuController(shouldExpand: isExpanded, location: location)
    }
}
