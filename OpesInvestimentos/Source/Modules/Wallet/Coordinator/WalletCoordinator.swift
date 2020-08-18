//
//  WalletCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class WalletCoordinator: CoordinatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = WalletCollectionViewController.instantiateFromStoryboard(.wallet)
        mainViewController.coordinator = self
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}
