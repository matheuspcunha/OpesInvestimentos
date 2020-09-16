//
//  TabBarController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    var coordinator: TabBarCoordinator?

    override func viewDidLoad() {
        self.view.backgroundColor = .clear
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .appBlue
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = .white
    }
}
