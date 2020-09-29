//
//  InvestimentListTableViewFactory.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct InvestimentListTableViewFactory: TableViewFactoryProtocol {
    
    typealias SelectedAsset = (InvestimentAsset) -> Void

    private let investiment: Investiment
    private let selectedAsset: SelectedAsset?

    init(investiment: Investiment, selectedAsset: SelectedAsset?) {
        self.investiment = investiment
        self.selectedAsset = selectedAsset
    }
    
    func make() -> [TableViewSection] {
        let total = section(builder: [TotalAssetCellBuilder(color: investiment.type.color, total: investiment.total)])
        let assets = section(builder: self.investiment.assets.map({ item in
            return AssetCellBuilder(asset: item, didSelect: {self.selectedAsset?(item)})
        }))
        let chart = section(builder: [AssetsChartCellBuilder(assets: investiment.assets, total: investiment.total)])

        return [total, assets, chart]
    }

    private func section(builder: [TableViewCellBuilder], title: String? = nil) -> TableViewSection {
        StaticSection(cellBuilders: builder)
    }
}
