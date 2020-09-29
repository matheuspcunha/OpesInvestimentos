//
//  InvestimentDetailCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentDetailCoordinator: CoordinatorProtocol {

    var navigationController: UINavigationController
    private var asset: InvestimentAsset
    
    init(navigationController: UINavigationController, asset: InvestimentAsset) {
        self.navigationController = navigationController
        self.asset = asset
    }
    
    func start() {
        let viewData = InvestimentDetailViewData(asset: asset)
        let viewModel = InvestimentDetailViewModel(coordinator: self, viewData: viewData)
        let investimentDetailVC = InvestimentDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(investimentDetailVC, animated: true)
    }
}

extension InvestimentDetailCoordinator: InvestimentDetailCoordinatorProtocol {}
