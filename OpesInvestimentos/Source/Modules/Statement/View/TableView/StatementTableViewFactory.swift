//
//  StatementTableViewFactory.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct StatementTableViewFactory: TableViewFactoryProtocol {

    private let data: StatementViewDataProtocol

    init(viewData: StatementViewDataProtocol) {
        self.data = viewData
    }

    func make() -> [TableViewSection] {
        var sections: [TableViewSection] = []

        let operations = Dictionary(grouping: data.operations) { (element) -> Date in
            return element.date
        }
        
        let movements = operations.sorted{ $0.key < $1.key }.reversed()
        for m in movements {
            let components = Calendar.current.dateComponents([.year], from: Date(), to: m.key)
            if (m.key <= Date() && components.year! >= 0) {
                sections.append(section(movements: m.value, date: m.key))
            }
        }

        return sections
    }

    private func section(movements builder: [Statement],
                         date: Date) -> TableViewSection {
        StaticSection(cellBuilders: builder.map(StatementCellBuilder.init),
                      header: DateHeader(date: Formatter.dateFormatter.string(from: date)))
    }
}
