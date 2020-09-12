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

    private let data: WalletViewDataProtocol
    
    init(viewData: WalletViewDataProtocol) {
        self.data = viewData
    }
    
    func make() -> [TableViewSection] {
        let sections = [section(builder: [TotalCellBuilder(value: data.total)], title: "Olá, \(data.name)! 🤑"),
                        section(builder: data.investiments.map(InvestimentCellBuilder.init)),
                        section(builder: [PieChartCellBuilder(model: data.investiments)])]
        
        return sections
    }

    private func section(builder: [TableViewCellBuilder], title: String? = nil) -> TableViewSection {
        StaticSection(cellBuilders: builder, header: header(title: title))
    }

    private func header(title: String?) -> UIView? {
        guard let title = title else { return nil }
        return SimpleHeader(title: title)
    }
}
