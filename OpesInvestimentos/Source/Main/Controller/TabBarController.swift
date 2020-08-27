//
//  TabBarController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .appBlue
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
    }
    
    var coordinator: TabBarCoordinator?
}
