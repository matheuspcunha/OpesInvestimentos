//
//  InvestimentDetailsViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct InvestimentDetailsViewData: InvestimentDetailsViewDataProtocol {
    
    var asset: InvestimentAsset
    
    var amountInvested: Double {
        return (asset.averagePrice * Double(asset.quantity))
    }
    
    var appreciation: Double {
        (asset.total - amountInvested)
    }

    var yielded: Double {
        (appreciation / amountInvested)
    }
    
    init(asset: InvestimentAsset) {
        self.asset = asset
    }
}
