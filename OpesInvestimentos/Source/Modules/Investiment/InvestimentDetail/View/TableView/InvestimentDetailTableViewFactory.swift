//
//  InvestimentDetailTableViewFactory.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct InvestimentDetailTableViewFactory: TableViewFactoryProtocol {

    private let data: InvestimentDetailViewDataProtocol

    init(data: InvestimentDetailViewDataProtocol) {
        self.data = data
    }
    
    func make() -> [TableViewSection] {
        guard let prices = data.prices else {return []}
        let lastUpdate = prices.reduce(prices[0], { $0.date > $1.date ? $0 : $1 } )
        
        let price = section(builder: [PricesCellBuilder(price: lastUpdate, asset: data.asset)])
        let chart = section(builder: [PriceChartCellBuilder(prices: prices)])
        return [price, chart]
    }

    private func section(builder: [TableViewCellBuilder]) -> TableViewSection {
        StaticSection(cellBuilders: builder)
    }
}
