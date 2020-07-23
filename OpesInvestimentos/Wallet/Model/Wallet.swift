//
//  Wallet.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Wallet: Decodable {
    
    let institution: String
    let account: String
    let stockWallet: [StockWallet]?
    let nationalTreasuryWallet: [nationalTreasuryWallet]?

    struct StockWallet: Decodable {
        
        let company: String
        let stockType: String
        let code: String
        let isin: String
        let price: Double
        let quantity: Int
        let quotationFactor: Int
        let totalValue: Double
        
        func toData() -> [String: Any] {
            let data: [String: Any] = [
                "company": self.company,
                "stockType": self.stockType,
                "code": self.code,
                "isin": self.isin,
                "price": self.price,
                "quantity": self.quantity,
                "quotationFactor": self.quotationFactor,
                "totalValue": self.totalValue,
            ]
            
            return data
        }
    }
    
    struct nationalTreasuryWallet: Decodable {

        let code: String
        let expirationDate: Date
        let investedValue: Double
        let grossValue: Double
        let netValue: Double
        let quantity: Double
        let blocked: Int

        func toData() -> [String: Any] {
            let data: [String: Any] = [
                "code": self.code,
                "expirationDate": Timestamp(date: self.expirationDate),
                "investedValue": self.investedValue,
                "grossValue": self.grossValue,
                "netValue": self.netValue,
                "quantity": self.quantity,
                "blocked": self.blocked
            ]
            
            return data
        }
    }
}
