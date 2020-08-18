//
//  RegisterCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol RegisterFlow: class {
    func coordinateTabBar()
}

class RegisterCoordinator: CoordinatorProtocol, RegisterFlow {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RegisterViewController.instantiateFromStoryboard(.register)
        viewController.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func coordinateTabBar() {
        // TODO
    }
}
