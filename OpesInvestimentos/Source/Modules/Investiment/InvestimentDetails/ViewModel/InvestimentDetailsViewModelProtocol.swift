//
//  InvestimentDetailsViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol InvestimentDetailsViewModelProtocol: class {
    var view: InvestimentDetailsViewProtocol? { get set }
    var viewData: InvestimentDetailsViewDataProtocol? { get set }
    
    func loadDetail()
}
