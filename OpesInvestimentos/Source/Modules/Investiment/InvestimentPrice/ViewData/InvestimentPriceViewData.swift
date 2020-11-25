//
//  InvestimentPriceViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct InvestimentPriceViewData: InvestimentPriceViewDataProtocol {
    
    var asset: InvestimentAsset
    var prices: [Price]?
    
    var currentPrice: Price? {
        guard let prices = prices else { return nil }
        return prices.reduce(prices[0], { $0.date > $1.date ? $0 : $1 } )
    }
    
    var variation: (Double, Double) {
        var value: Double = 0
        var percent: Double = 0
        
        if let prices = prices {
            let lastDate = prices.map({$0.date}).sorted(by: { $0.compare($1) == .orderedDescending })[1]
            
            guard let currentPrice = currentPrice,
                  let lastPrice = prices.first(where: {$0.date == lastDate} )
            else { return (value, percent) }

            value = (currentPrice.close - lastPrice.close)
            percent = abs(value/lastPrice.close)
        }
        
        return (value, percent)
    }
    
    init(asset: InvestimentAsset) {
        self.asset = asset
        self.prices = nil
    }
}
