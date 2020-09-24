//
//  AppCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Firebase

final class AppCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if Auth.auth().currentUser != nil {
            FirebaseService.checkIfExist(collection: .wallet) { (result) in
                if result {
                    self.showHome()
                } else {
                    self.showImportCEI()
                }
            }
        } else {
            showWelcome()
        }
    }
    
    private func showWelcome() {
        let startCoordinator = WelcomeCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
    
    private func showHome() {
        let startCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
    
    private func showImportCEI() {
        let importCEICoordinator = ImportCEICoordinator(navigationController: navigationController)
        coordinate(to: importCEICoordinator)
    }
}
