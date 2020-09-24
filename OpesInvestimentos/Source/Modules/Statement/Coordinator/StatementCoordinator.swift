//
//  StatementCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 09/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class StatementCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = StatementViewModel(coordinator: self)
        let statementVC = StatementViewController(viewModel: viewModel)
        navigationController.pushViewController(statementVC, animated: true)
    }
}

extension StatementCoordinator: StatementCoordinatorProtocol {}
