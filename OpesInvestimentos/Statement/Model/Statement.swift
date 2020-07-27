//
//  Statement.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum Operation: String {
    case Compra = "Compra"
    case Venda = "Venda"
    case Dividendo = "Dividendo"
    case JurosCapital = "Juros Sobre Capital"
    case Leilao = "Leilão de Frações"
}

class Statement {
    
    let date: Date
    private let operation: String
    let code: String
    let quantity: Int
    let price: Double
    let total: Double
    
    init(date: Date, operation: String, code: String, quantity: Int, price: Double, total: Double) {
        self.date = date
        self.operation = operation
        self.code = code
        self.quantity = quantity
        self.total = total
        self.price = price == 0 ? (total / Double(quantity)) : price
    }
    
    convenience init(dictionary data: [String: Any]) {
        let date = Timestamp.dateValue(data["date"] as! Timestamp)()
        let operation = (data["operation"] as? String) ?? ""
        let code = (data["code"] as? String) ?? ""
        let quantity = (data["quantity"] as? Int) ?? 0
        let price = (data["price"] as? Double) ?? 0.0
        let total = (data["total"] as? Double) ?? 0.0
        
        self.init(date: date, operation: operation, code: code, quantity: quantity, price: price, total: total)
    }
    
    var type: Operation {
        switch self.operation {
        case "C", "Compra":
            return Operation.Compra
        case "V", "Venda":
            return Operation.Venda
        case "DIVIDENDO", "Dividendo", "RENDIMENTO":
            return Operation.Dividendo
        case "JUROS SOBRE CAPITAL PRÓPRIO", "Juros Sobre Capital":
            return Operation.JurosCapital
        default:
            return Operation.Leilao
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
