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
    let nationalTreasuryWallet: [NationalTreasuryWallet]?

    init(dictionary data: [String: Any]) {

        var sw: [StockWallet] = []
        if let data = data["stockWallet"] as? [Any] {
            let stock = data.map({$0 as! [String: Any]})
                
            for s in stock {
                sw.append(StockWallet(dictionary: s))
            }
        }
        
        var nt: [NationalTreasuryWallet] = []
        if let data = data["nationalTreasuryWallet"] as? [Any] {
            let treasury = data.map({$0 as! [String: Any]})
            
            for t in treasury {
                nt.append(NationalTreasuryWallet(dictionary: t))
            }
        }
        
        self.institution = (data["institution"] as? String) ?? ""
        self.account = (data["account"] as? String) ?? ""
        self.stockWallet = sw
        self.nationalTreasuryWallet = nt
    }
    
    var dictionary:[String:Any] {
        return [
            "institution": self.institution,
            "account": self.account,
            "stockWallet": self.stockWallet?.map({$0.dictionary}) ?? NSNull(),
            "nationalTreasuryWallet": self.nationalTreasuryWallet?.map({$0.dictionary}) ?? NSNull()
        ]
    }
}

struct StockWallet: Decodable {
    
    let company: String
    let stockType: String
    let code: String
    let isin: String
    let price: Double
    let quantity: Int
    let quotationFactor: Int
    let totalValue: Double
    
    init(dictionary data: [String: Any]) {
        self.company = (data["company"] as? String) ?? ""
        self.stockType = (data["stockType"] as? String) ?? ""
        self.code = (data["code"] as? String) ?? ""
        self.isin = (data["isin"] as? String) ?? ""
        self.price = (data["price"] as? Double) ?? 0.0
        self.quantity = (data["quantity"] as? Int) ?? 0
        self.quotationFactor = (data["quotationFactor"] as? Int) ?? 0
        self.totalValue = (data["totalValue"] as? Double) ?? 0.0
    }
    
    var dictionary:[String:Any] {
        return [
            "company": self.company,
            "stockType": self.stockType,
            "code": self.code,
            "isin": self.isin,
            "price": self.price,
            "quantity": self.quantity,
            "quotationFactor": self.quotationFactor,
            "totalValue": self.totalValue,
        ]
    }
}

struct NationalTreasuryWallet: Decodable {

    let code: String
    let expirationDate: Date
    let investedValue: Double
    let grossValue: Double
    let netValue: Double
    let quantity: Double
    let blocked: Int

    init(dictionary data: [String: Any]) {
        self.code = (data["code"] as? String) ?? ""
        self.expirationDate = ISO8601DateFormatter().date(from: (data["expirationDate"] as? String) ?? "") ?? Date()
        self.investedValue = (data["investedValue"] as? Double) ?? 0.0
        self.grossValue = (data["grossValue"] as? Double) ?? 0.0
        self.netValue = (data["netValue"] as? Double) ?? 0.0
        self.quantity = (data["quantity"] as? Double) ?? 0.0
        self.blocked = (data["blocked"] as? Int) ?? 0
    }
    
    var dictionary:[String:Any] {
        return [
            "code": self.code,
            "expirationDate": Timestamp(date: self.expirationDate),
            "investedValue": self.investedValue,
            "grossValue": self.grossValue,
            "netValue": self.netValue,
            "quantity": self.quantity,
            "blocked": self.blocked
        ]
    }
}
