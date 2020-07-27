//
//  WalletViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol WalletViewModelDelegate: class {
    func onLoadWallet(error: FirebaseError?)
}

class WalletViewModel {
    
    // MARK: - Properties

    private var sections: [Section] = [] {
        didSet {
            walletLoaded?()
        }
    }
    
    weak var delegate: WalletViewModelDelegate?
    
    var walletLoaded: (()->Void)?

    var count: Int {
        return sections.count
    }
    
    // MARK: - Methods

    func loadWallet() {
        
        FirebaseService.getSubCollection(collection: .wallet) { (query, error) in
            var wallet:[Wallet] = []
            
            guard let query = query, error == nil else {
                self.walletLoaded?()
                return
            }
            
            for document in query.documents {
                let data = document.data()
                wallet.append(Wallet(dictionary: data))
            }
            
            self.sections = [
                NameSection(name: "Everton"),
                TotalSection(total: self.getTotal(wallet: wallet))
            ]
        }
    }
    
    func getSection(in index: Int) -> Section {
        return sections[index]
    }
    
    func numberOfItems(in section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func getTotal(wallet:[Wallet]) -> Double {
        var total: Double = 0
        
        for w in wallet {
            if let treasure = w.nationalTreasuryWallet {
                if !treasure.isEmpty {
                    for t in treasure {
                        total += t.grossValue
                    }
                }
            }

            if let stock = w.stockWallet {
                if !stock.isEmpty {
                    for s in stock {
                        total += s.totalValue
                    }
                }
            }
        }
                
        return total
    }
}

