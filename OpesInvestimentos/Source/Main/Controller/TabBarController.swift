//
//  TabBarController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .default
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor(named: "AppBlue")
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    
    var coordinator: TabBarCoordinator?
}
