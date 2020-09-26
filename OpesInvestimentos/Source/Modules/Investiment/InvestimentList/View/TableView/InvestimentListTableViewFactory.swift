//
//  InvestimentListTableViewFactory.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct InvestimentListTableViewFactory: TableViewFactoryProtocol {

    private let investiment: Investiment
    
    init(investiment: Investiment) {
        self.investiment = investiment
    }
    
    func make() -> [TableViewSection] {
        let total = section(builder: [TotalAssetCellBuilder(color: investiment.type.color, total: investiment.total)])
        let assets = section(builder: self.investiment.assets.map(AssetCellBuilder.init))
        let chart = section(builder: [AssetsChartCellBuilder(assets: investiment.assets, total: investiment.total)])

        return [total, assets, chart]
    }

    private func section(builder: [TableViewCellBuilder], title: String? = nil) -> TableViewSection {
        StaticSection(cellBuilders: builder, header: header(title: title))
    }

    private func header(title: String?) -> UIView? {
        guard let title = title else { return nil }
        return SimpleHeader(title: title)
    }
}
