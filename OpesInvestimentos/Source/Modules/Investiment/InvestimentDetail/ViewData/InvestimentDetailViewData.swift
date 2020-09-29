//
//  InvestimentDetailViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct InvestimentDetailViewData: InvestimentDetailViewDataProtocol {
    var asset: InvestimentAsset
    var prices: [Price]?
    
    init(asset: InvestimentAsset) {
        self.asset = asset
        self.prices = nil
    }
}
