//
//  InvestimentDetailsCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentDetailsCoordinator: CoordinatorProtocol {

    var navigationController: UINavigationController
    private var asset: InvestimentAsset
    
    init(navigationController: UINavigationController, asset: InvestimentAsset) {
        self.navigationController = navigationController
        self.asset = asset
    }
    
    func start() {
        let viewData = InvestimentDetailsViewData(asset: asset)
        let viewModel = InvestimentDetailsViewModel(coordinator: self, viewData: viewData)
        let investimentDetailsVC = InvestimentDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(investimentDetailsVC, animated: true)
    }
}

extension InvestimentDetailsCoordinator: InvestimentDetailsCoordinatorProtocol {

    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func showPrice(to asset: InvestimentAsset) {
        let investimentDetail = InvestimentPriceCoordinator(navigationController: navigationController,
                                                            asset: asset)
        coordinate(to: investimentDetail)
    }
}
