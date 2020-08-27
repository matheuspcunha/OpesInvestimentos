//
//  WelcomeCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class WelcomeCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = WelcomeViewModel(coordinator: self)
        let viewController = WelcomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension WelcomeCoordinator: WelcomeCoordinatorProtocol {
    
    func coordinateToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: loginCoordinator)
    }
    
    func coordinateToRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        coordinate(to: registerCoordinator)
    }
}
