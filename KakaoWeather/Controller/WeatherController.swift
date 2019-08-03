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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func configureConstraints() {
        navigationItem.leftBarButtonItem = hamburgerButton
    }
    
    @objc func handleSideMenuToggle() {
        delegate?.handleSideMenuToggle()
    }
}
