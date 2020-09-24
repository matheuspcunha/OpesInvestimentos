//
//  WalletService.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol WalletServiceProtocol {
    func getWallet(onComplete: @escaping ((wallet: [Wallet], statement: [Statement])?, FirebaseError?) -> Void)
}

struct WalletService: WalletServiceProtocol {
    
    func getWallet(onComplete: @escaping ((wallet: [Wallet], statement: [Statement])?, FirebaseError?) -> Void) {

        var wallet = [Wallet]()
        FirebaseService.getData(collection: .wallet) { (query, error) in
            guard let query = query, error == nil else {
                return onComplete(nil, error)
            }

            for document in query.documents {
                let data = document.data()
                wallet.append(Wallet(dictionary: data))
            }
        }
        
        FirebaseService.getData(collection: .statement) { (query, error) in
            guard let query = query, error == nil else {
                return onComplete(nil, error)
            }

            var statement = [Statement]()
            for document in query.documents {
                var data = document.data()
                data["id"] = document.documentID
                statement.append(Statement(dictionary: data))
            }

            onComplete((wallet, statement), nil)
        }
    }
}
