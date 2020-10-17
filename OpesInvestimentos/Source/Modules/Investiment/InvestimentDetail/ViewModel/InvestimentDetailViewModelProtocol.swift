//
//  InvestimentDetailViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol InvestimentDetailViewModelProtocol: class {
    var view: InvestimentDetailViewProtocol? { get set }
    var delegate: InvestimentDetailViewModelDelegate? { get set }
    var viewData: InvestimentDetailViewDataProtocol? { get set }
    
    func loadDetail()
}

protocol InvestimentDetailViewModelDelegate: class {
    func onLoadDetail()
}
