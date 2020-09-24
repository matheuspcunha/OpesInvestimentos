//
//  StatementViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

struct StatementViewData: StatementViewDataProtocol {

    var operations: [Statement] {
        didSet {
            operations.sort(by: { $0.date > $1.date})
        }
    }
    
    var count: Int { return operations.count }
    
    init(operations: [Statement]) {
        self.operations = operations
    }
}
