//
//  InvestimentPriceViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol InvestimentPriceViewModelProtocol: class {
    var view: InvestimentPriceViewProtocol? { get set }
    var delegate: InvestimentPriceViewModelDelegate? { get set }
    var viewData: InvestimentPriceViewDataProtocol? { get set }
    
    func loadDetail()
}

protocol InvestimentPriceViewModelDelegate: class {
    func onLoadPrice()
}
