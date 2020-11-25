//
//  InvestimentDetailsViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class InvestimentDetailsViewModel: InvestimentDetailsViewModelProtocol {
    
    weak var view: InvestimentDetailsViewProtocol?
    
    var viewData: InvestimentDetailsViewDataProtocol?
    
    private var coordinator: InvestimentDetailsCoordinatorProtocol?

    init(coordinator: InvestimentDetailsCoordinatorProtocol?,
         viewData: InvestimentDetailsViewDataProtocol) {
        self.coordinator = coordinator
        self.viewData = viewData
    }

    func showPrice() {
        guard let asset = viewData?.asset else { return }
        coordinator?.showPrice(to: asset)
    }
    
    private func exit() {
        coordinator?.back()
    }
}
