//
//  CEI.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct History: Decodable {
    
    let institution: String
    let account: String
    let stockHistory: [StockHistory]?
    
    struct StockHistory: Decodable {
        
        let date: Date
        let operation: String
        let market: String
        let expiration: String?
        let code: String
        let name: String
        let quantity: Int
        let price: Double
        let totalValue: Double
        let quotationFactor: Int
        
        var operationType: String {
            switch operation {
            case "C":
                return "Compra"
            default:
                return "Venda"
            }
        }
    }
}

struct Dividends: Decodable {
    
    let stockType: String
    let code: String
    var date: Date
    let type: String
    let quantity: Int
    let factor: Int
    let grossValue: Double
    let netValue: Double
}
