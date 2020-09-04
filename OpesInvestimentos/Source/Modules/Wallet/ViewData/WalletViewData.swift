//
//  WalletViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct WalletViewData: WalletViewDataProtocol {
    
    var investiments: [Investiment] = []
    
    var name: String {
        return "Matheus"
    }
    
    var total: String {
        investiments.map({$0.value}).reduce(0, +).formatCurrency()
    }
    
    init(wallet: [Wallet]) {
        self.investiments = parseInvestiments(in: wallet)
    }

    private func parseInvestiments(in wallet: [Wallet]) ->  [Investiment] {
        var totalFunds: Double = 0
        var totalStock: Double = 0
        var totalTreasury: Double = 0

        for w in wallet {
            if let stock = w.stockWallet {
                if !stock.isEmpty {
                    for s in stock {
                        if s.stockType.contains("CI") {
                            totalFunds += s.totalValue
                        } else {
                            totalStock += s.totalValue
                        }
                    }
                }
            } else if let treasure = w.nationalTreasuryWallet {
                if !treasure.isEmpty {
                    for t in treasure {
                        totalTreasury += t.grossValue
                    }
                }
            }
        }

        return [Investiment(type: .funds, value: totalFunds),
                Investiment(type: .stock, value: totalStock),
                Investiment(type: .treasure, value: totalTreasury)]
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
