//
//  StatementCellViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class StatementCellViewModel {
    
    private var statement: Statement

    init(statement: Statement) {
        self.statement = statement
    }
    
    var code: String {
        self.statement.code
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter.string(from: self.statement.date)
    }
    
    var unityPrice: String {
        let price = statement.price.formatCurrency()
        return "\(price) x \(self.statement.quantity) unidades"
    }
    
    var price: String {
        var price: String
        
        if self.statement.type == .dividendo || self.statement.type == .jurosCapital {
            price = "+ " + statement.total.formatCurrency()
        } else if self.statement.type == .venda {
            price = "- " + statement.total.formatCurrency()
        } else {
            price = statement.total.formatCurrency()
        }
        
        return price
    }
    
    var operationType: String {
        return self.statement.type == .leilao ? "Juros Sobre Capital" : self.statement.type.rawValue
    }
}
