//
//  InvestimentListViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class InvestimentListViewModel: InvestimentListViewModelProtocol {

    weak var view: InvestimentListViewProtocol?
    
    private var coordinator: InvestimentListCoordinatorProtocol?
    
    var investiment: Investiment
    
    var attributes: InvestimentType {
        self.investiment.type
    }
    
    init(coordinator: InvestimentListCoordinatorProtocol?,
         investiment: Investiment) {
        self.coordinator = coordinator
        self.investiment = investiment
    }
}
