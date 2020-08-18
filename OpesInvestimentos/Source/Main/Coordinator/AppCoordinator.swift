//
//  AppCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = WelcomeCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
