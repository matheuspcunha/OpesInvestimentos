//
//  LoginCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol LoginFlow: class {
    func coordinateToTabBar()
    func coordinateToForgotPassword()
    func coordinateToImportCEI()

}

class LoginCoordinator: CoordinatorProtocol, LoginFlow {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel(coordinator: self)
        let viewController = LoginViewController(viewModel: viewModel)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController!)
        coordinate(to: tabBarCoordinator)
    }
    
    func coordinateToForgotPassword() {
        print("coordinateForgotPassword")
    }
    
    func coordinateToImportCEI() {
        print("coordinateToImportCEI")
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(_ alert: UIAlertController) {
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
