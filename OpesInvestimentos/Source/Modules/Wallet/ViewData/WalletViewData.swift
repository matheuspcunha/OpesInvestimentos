//
//  WalletViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct WalletViewData: WalletViewDataProtocol {

    var investiments: [Investiment]
    var name: String
    var totalCost: Double
    
    var total: Double {
        investiments.map({$0.total}).reduce(0, +)
    }
    
    var result: Double {
        (total - totalCost)
    }
    
    var variation: Double {
        (result / totalCost)
    }
}

struct Investiment {
    
    var type: InvestimentType
    var assets: [InvestimentAsset]
    
    var total: Double {
        assets.map({$0.total}).reduce(0, +)
    }
}

struct InvestimentAsset {
    let symbol: String
    let name: String
    let price: Double
    let quantity: Int
    let total: Double
    var color: UIColor
}
