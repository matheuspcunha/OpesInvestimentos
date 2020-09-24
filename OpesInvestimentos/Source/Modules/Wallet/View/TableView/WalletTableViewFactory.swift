//
//  WalletTableViewFactory.swift
//  TableViewFactoryTest
//
//  Created by Matheus Cunha on 31/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol TableViewFactoryProtocol {
    func make() -> [TableViewSection]
}

struct WalletTableViewFactory: TableViewFactoryProtocol {

    typealias SelectedInvestiment = (Investiment) -> Void

    private let data: WalletViewDataProtocol
    private let selectedInvestiment: SelectedInvestiment?
    
    init(viewData: WalletViewDataProtocol, selectedInvestiment: SelectedInvestiment?) {
        self.data = viewData
        self.selectedInvestiment = selectedInvestiment
    }
    
    func make() -> [TableViewSection] {
        let total = section(builder: [TotalCellBuilder(value: data.total)], title: "Oi, \(data.name)! 🤑")
        let detail = section(builder: [DetailCellBuilder(totalCost: data.totalCost, result: data.result, variation: data.variation)])
        let investiments = section(builder: data.investiments.map({ item in
            return InvestimentCellBuilder(investiment: item, didSelect: {self.selectedInvestiment?(item)})
        }))
        let chart = section(builder: [PieChartCellBuilder(model: data)])

        return [total, detail, investiments, chart]
    }

    private func section(builder: [TableViewCellBuilder], title: String? = nil) -> TableViewSection {
        StaticSection(cellBuilders: builder, header: header(title: title))
    }

    private func header(title: String?) -> UIView? {
        guard let title = title else { return nil }
        return SimpleHeader(title: title)
    }
}
