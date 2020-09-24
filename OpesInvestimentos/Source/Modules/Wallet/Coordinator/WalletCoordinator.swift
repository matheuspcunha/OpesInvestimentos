//
//  WalletCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WalletCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = WalletViewModel(coordinator: self)
        let walletVC = WalletViewController(viewModel: viewModel)
        navigationController.pushViewController(walletVC, animated: true)
    }
}

extension WalletCoordinator: WalletCoordinatorProtocol {
    func showInvestimentList(for investiment: Investiment) {
        let investimentList = InvestimentListCoordinator(navigationController: navigationController,
                                                         investiment: investiment)
        coordinate(to: investimentList)
    }
}
