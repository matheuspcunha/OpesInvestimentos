//
//  InvestimentListViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol InvestimentListViewModelProtocol: class {
    var view: InvestimentListViewProtocol? { get set }
    var attributes: InvestimentType { get }
    var investiment: Investiment { get set }
}
