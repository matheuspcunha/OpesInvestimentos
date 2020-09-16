//
//  ImportCEICoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class ImportCEICoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewData = ImportCEIViewData(cpf: Defaults.shared.cpf ?? "")
        let viewModel = ImportCEIViewModel(coordinator: self, viewData: viewData)
        let viewController = ImportCEIViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ImportCEICoordinator: ImportCEICoordinatorProtocol {
    
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func openCEIWebsite() {}
}
