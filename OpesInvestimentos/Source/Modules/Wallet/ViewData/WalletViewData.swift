//
//  WalletViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct WalletViewData: WalletViewDataProtocol {
    
    var investiments: [Investiment]
    var name: String
    var total: String {
        investiments.map({$0.value}).reduce(0, +).formatCurrency()
    }

    init(name: String, investiments: [Investiment]) {
        self.name = name
        self.investiments = investiments
    }
}

struct Investiment {
    let type: InvestimentType
    let value: Double
    
    init(type: InvestimentType, value: Double) {
        self.type = type
        self.value = value
    }
}
