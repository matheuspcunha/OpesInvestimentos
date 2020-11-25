//
//  InvestimentPriceViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class InvestimentPriceViewModel: InvestimentPriceViewModelProtocol {
    
    weak var view: InvestimentPriceViewProtocol?
    weak var delegate: InvestimentPriceViewModelDelegate?
    
    var viewData: InvestimentPriceViewDataProtocol?
    
    private var coordinator: InvestimentPriceCoordinatorProtocol?
    private var service: InvestimentPriceServiceProtocol

    init(coordinator: InvestimentPriceCoordinatorProtocol?,
         service: InvestimentPriceServiceProtocol = InvestimentPriceService(),
         viewData: InvestimentPriceViewDataProtocol) {
        self.coordinator = coordinator
        self.service = service
        self.viewData = viewData
    }

    func loadDetail() {
        coordinator?.showLoading(true)
        guard let symbol = viewData?.asset.symbol else { return }

        service.getPrices(symbol: symbol) { result in
            self.coordinator?.showLoading(false)

            switch result {
            case .success(let prices):
                self.viewData?.prices = prices
                self.delegate?.onLoadPrice()
            case .failure:
                self.coordinator?.showAlert(Alert.make(title: "Ops!",
                                                       message: "Não foi possível exibir as informações. Tente novamente mais tarde",
                                                       handler: self.backScreen))
            }
        }
    }

    func backScreen() {
        coordinator?.back()
    }
}
