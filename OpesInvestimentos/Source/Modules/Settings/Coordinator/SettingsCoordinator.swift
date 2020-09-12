//
//  SettingsCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 11/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class SettingsCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SettingsViewModel(coordinator: self)
        let settingsViewController = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}

extension SettingsCoordinator: SettingsCoordinatorProtocol {}
