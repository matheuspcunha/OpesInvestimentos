//
//  InvestimentListCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentListCoordinator: CoordinatorProtocol {

    var navigationController: UINavigationController
    private var investiment: Investiment
    
    init(navigationController: UINavigationController, investiment: Investiment) {
        self.navigationController = navigationController
        self.investiment = investiment
    }
    
    func start() {
        let viewModel = InvestimentListViewModel(coordinator: self, investiment: investiment)
        let investimentListVC = InvestimentListViewController(viewModel: viewModel)
        navigationController.pushViewController(investimentListVC, animated: true)
    }
}

extension InvestimentListCoordinator: InvestimentListCoordinatorProtocol {

    func showDetail(to asset: InvestimentAsset) {
        let investimentDetail = InvestimentDetailCoordinator(navigationController: navigationController,
                                                             asset: asset)
        coordinate(to: investimentDetail)
    }
}
