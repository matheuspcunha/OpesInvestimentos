//
//  InvestimentDetailViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class InvestimentDetailViewModel: InvestimentDetailViewModelProtocol {
    
    weak var view: InvestimentDetailViewProtocol?
    weak var delegate: InvestimentDetailViewModelDelegate?
    
    var viewData: InvestimentDetailViewDataProtocol?
    
    private var coordinator: InvestimentDetailCoordinatorProtocol?
    private var service: InvestimentDetailServiceProtocol

    init(coordinator: InvestimentDetailCoordinatorProtocol?,
         service: InvestimentDetailServiceProtocol = InvestimentDetailService(),
         viewData: InvestimentDetailViewDataProtocol) {
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
                self.delegate?.onLoadDetail()
            case .failure:
                print("Não foi possível exibir o gráfico")
            }
        }
    }
}
