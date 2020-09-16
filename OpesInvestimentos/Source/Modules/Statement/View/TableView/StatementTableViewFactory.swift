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
        
        let movements = Dictionary(grouping: data.operations) { (element) -> Date in
            return element.date
        }
        
        movements.keys.forEach { (day) in
            if let movements = movements[day] {
                sections.append(section(movements: movements, ofTheDay: day))
            }
        }
        
        return sections
    }
    
    private func section(movements builder: [Statement],
                         ofTheDay date: Date) -> TableViewSection {
    
        StaticSection(cellBuilders: builder.map(StatementCellBuilder.init),
                      header: DateHeader(date: Formatter.dateFormatter.string(from: date)))
    }
}
