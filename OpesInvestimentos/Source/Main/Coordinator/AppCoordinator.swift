//
//  AppCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
