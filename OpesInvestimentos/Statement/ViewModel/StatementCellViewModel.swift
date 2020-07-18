//
//  StatementCellViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class StatementCellViewModel {
    
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
        let price = Formatter.currencyFormatter.string(from: NSNumber(value: statement.price)) ?? "R$ \(statement.price)"
        return "\(price) x \(self.statement.quantity) unidades"
    }
    
    var price: String {
        var price: String
        
        if self.statement.type == .Dividendo || self.statement.type == .JurosCapital {
            price = "+ " + (Formatter.currencyFormatter.string(from: NSNumber(value: statement.total)) ?? "R$ \(statement.total)")
        } else if self.statement.type == .Venda {
            price = "- " + (Formatter.currencyFormatter.string(from: NSNumber(value: statement.total)) ?? "R$ \(statement.total)")

        } else {
            price = Formatter.currencyFormatter.string(from: NSNumber(value: statement.total)) ?? "R$ \(statement.total)"
        }
        
        return price
    }
    
    var operationType: String {
        return self.statement.type.rawValue
    }
}
