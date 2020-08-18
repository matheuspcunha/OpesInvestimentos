//
//  WelcomeCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol WelcomeFlow: class {
    func coordinateToLogin()
    func coordinateToRegister()
}

class WelcomeCoordinator: CoordinatorProtocol, WelcomeFlow {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = WelcomeViewController()
        viewController.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func coordinateToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController!)
        coordinate(to: loginCoordinator)
    }
    
    func coordinateToRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController!)
        coordinate(to: registerCoordinator)
    }
}
