//
//  InvestimentDetailViewDataProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

protocol InvestimentDetailViewDataProtocol {
    var asset: InvestimentAsset { get }
    var prices: [Price]? { get set }
}
