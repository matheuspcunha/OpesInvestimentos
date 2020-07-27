//
//  CEI.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct History: Decodable {
    
    let institution: String
    let account: String
    let stockHistory: [StockHistory]?
    
    var dictionary:[String:Any] {
        return [
            "institution": self.institution,
            "account": self.account,
            "stockHistory": self.stockHistory?.map({$0.dictionary}) ?? NSNull()
        ]
    }
    
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

        var dictionary:[String:Any] {
            return [
                "date": Timestamp(date: self.date),
                "operation": self.operationType,
                "market": self.market,
                "expiration": self.expiration ?? "",
                "code": self.code,
                "name": self.name,
                "quantity": self.quantity,
                "price": self.price,
                "totalValue": self.totalValue,
                "quotationFactor": self.quotationFactor
            ]
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
    
    var dictionary:[String:Any] {
        return [
            "stockType": self.stockType,
            "code": self.code,
            "date": Timestamp(date: self.date),
            "type": self.type,
            "quantity": self.quantity,
            "factor": self.factor,
            "grossValue": self.grossValue,
            "netValue": self.netValue
        ]
    }
}
