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
        return [section(builder: TotalCellBuilder(value: data.total), title: "Olá, \(data.name)! 🤑"),
                section(builder: builderCells(in: data.investiments))]
    }

    private func section(builder: TableViewCellBuilder, title: String? = nil) -> TableViewSection {
        StaticSection(cellBuilders: [builder], header: header(title: title))
    }

    private func section(builder: [TableViewCellBuilder]) -> TableViewSection {
        StaticSection(cellBuilders: builder)
    }

    private func header(title: String?) -> UIView? {
        if let title = title { return SimpleHeader(title: title) }
        return nil
    }
    
    private func builderCells(in investiments: [Investiment]) -> [TableViewCellBuilder] {
        return investiments.map(InvestimentCellBuilder.init)
    }
}
