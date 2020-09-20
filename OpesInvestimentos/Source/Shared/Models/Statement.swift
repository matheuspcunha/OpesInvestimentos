//
//  Statement.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension Operation: CaseIterable { }

enum Operation: String {
    case todos = "Todos"
    case compra = "Compra"
    case venda = "Venda"
    case dividendo = "Dividendo"
    case jurosCapital = "Juros"
    case leilao = "Leilão de Frações"
}

struct Statement {
    
    let id: String?
    let date: Date
    private let operation: String
    let code: String
    let quantity: Int
    let price: Double
    let total: Double
    
    init(id: String?, date: Date, operation: String, code: String, quantity: Int, price: Double, total: Double) {
        self.id = id
        self.date = date
        self.operation = operation
        
        var symbol = code
        if let index = symbol.lastIndex(where: {$0 == "F"}) {
            symbol.remove(at: index)
        }
        self.code = symbol
        
        self.quantity = quantity
        self.total = total
        self.price = price == 0 ? (total / Double(quantity)) : price
    }
    
    init(dictionary data: [String : Any]) {
        let id = (data["id"] as? String) ?? ""
        let date = Timestamp.dateValue(data["date"] as! Timestamp)()
        let operation = (data["operation"] as? String) ?? ""
        
        var symbol = (data["code"] as? String) ?? ""
        if let index = symbol.lastIndex(where: {$0 == "F"}) {
            symbol.remove(at: index)
        }
        let code = symbol
        
        let quantity = (data["quantity"] as? Int) ?? 0
        let price = (data["price"] as? Double) ?? 0.0
        let total = (data["total"] as? Double) ?? 0.0
        
        self.init(id: id, date: date, operation: operation, code: code, quantity: quantity, price: price, total: total)
    }
    
    var type: Operation {
        switch self.operation {
        case "C", "Compra":
            return Operation.compra
        case "V", "Venda":
            return Operation.venda
        case "DIVIDENDO", "Dividendo", "RENDIMENTO":
            return Operation.dividendo
        case "JUROS SOBRE CAPITAL PRÓPRIO", "Juros Sobre Capital":
            return Operation.jurosCapital
        default:
            return Operation.leilao
        }
    }
    
    var dictionary:[String:Any] {
        return [
            "date":  Timestamp(date: self.date),
            "operation": self.operation,
            "code": self.code,
            "quantity": self.quantity,
            "price": self.price,
            "total": self.total
        ]
    }
}
