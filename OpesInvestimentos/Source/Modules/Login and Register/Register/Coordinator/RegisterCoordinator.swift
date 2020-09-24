//
//  RegisterCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class RegisterCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = RegisterViewModel(coordinator: self)
        let viewController = RegisterViewController(viewModel: viewModel)
        
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension RegisterCoordinator: RegisterCoordinatorProtocol {
    
    func coordinateToImportCEI() {
        let importCEICoordinator = ImportCEICoordinator(navigationController: navigationController)
        coordinate(to: importCEICoordinator)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func showAlert(_ alert: UIAlertController) {
        navigationController.present(alert, animated: true, completion: nil)
    }
}
