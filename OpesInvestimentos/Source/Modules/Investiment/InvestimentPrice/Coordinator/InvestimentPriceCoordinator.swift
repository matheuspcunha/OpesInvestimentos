//
//  InvestimentPriceCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentPriceCoordinator: CoordinatorProtocol {

    var navigationController: UINavigationController
    private var asset: InvestimentAsset
    
    init(navigationController: UINavigationController, asset: InvestimentAsset) {
        self.navigationController = navigationController
        self.asset = asset
    }
    
    func start() {
        let viewData = InvestimentPriceViewData(asset: asset)
        let viewModel = InvestimentPriceViewModel(coordinator: self, viewData: viewData)
        let investimentPriceVC = InvestimentPriceViewController(viewModel: viewModel)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.automatic
        navigationController.present(investimentPriceVC, animated: true, completion: nil)
    }
}

extension InvestimentPriceCoordinator: InvestimentPriceCoordinatorProtocol {

    func back() {
        navigationController.popViewController(animated: true)
    }
}
