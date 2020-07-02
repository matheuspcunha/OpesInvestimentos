//
//  Statement.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

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
        
        if (price == 0) {
            self.price = (total / Double(quantity))
        }
        else {
            self.price = price
        }
    }
    
    var type: Operation {
        switch self.operation {
        case "C":
            return Operation.Compra
        case "V":
            return Operation.Venda
        case "DIVIDENDO", "RENDIMENTO":
            return Operation.Dividendo
        case "JUROS SOBRE CAPITAL PRÓPRIO":
            return Operation.JurosCapital
        default:
            return Operation.Leilao
        }
    }
}
