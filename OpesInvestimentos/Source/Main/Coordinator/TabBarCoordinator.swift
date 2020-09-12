//
//  TabBarCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class TabBarCoordinator: CoordinatorProtocol {

    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let walletNavigationController = UINavigationController()
        walletNavigationController.tabBarItem = UITabBarItem(title: "Carteira", image: #imageLiteral(resourceName: "wallet"), tag: 0)
        let walletCoordinator = WalletCoordinator(navigationController: walletNavigationController)
        
        let statementNavigationController = UINavigationController()
        statementNavigationController.tabBarItem = UITabBarItem(title: "Extrato", image: UIImage(systemName: "list.dash"), tag: 1)
        let statementCoordinator = StatementCoordinator(navigationController: statementNavigationController)
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Ajustes", image: UIImage(systemName: "person"), tag: 2)
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNavigationController)
        
        tabBarController.viewControllers = [walletNavigationController,
                                            statementNavigationController,
                                            settingsNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)

        coordinate(to: walletCoordinator)
        coordinate(to: statementCoordinator)
        coordinate(to: settingsCoordinator)
    }
}
