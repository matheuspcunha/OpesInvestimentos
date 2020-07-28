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
    
    private var wallet:[Wallet] = []
    
    weak var delegate: WalletViewModelDelegate?
    
    var walletLoaded: (()->Void)?

    var count: Int {
        return sections.count
    }
    
    // MARK: - Methods

    func loadWallet() {
        
        FirebaseService.getSubCollection(collection: .wallet) { (query, error) in
            guard let query = query, error == nil else {
                self.walletLoaded?()
                return
            }
            
            self.wallet.removeAll()
            for document in query.documents {
                let data = document.data()
                self.wallet.append(Wallet(dictionary: data))
            }
            
            self.sections = [
                NameSection(name: "Everton"),
                TotalSection(total: self.totalWallet),
                TypeSection(total: self.totalStock, type: .Acoes),
                TypeSection(total: self.totalFunds, type: .Fundos),
                TypeSection(total: self.totalTreasury, type: .Tesouro)
            ]
        }
    }
    
    func getSection(in index: Int) -> Section {
        return sections[index]
    }
    
    func numberOfItems(in section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    private var totalWallet: Double {
        return totalStock + totalTreasury + totalFunds
    }
    
    private var totalTreasury: Double {
        var total: Double = 0
        
        for w in wallet {
            if let treasure = w.nationalTreasuryWallet {
                if !treasure.isEmpty {
                    for t in treasure {
                        total += t.grossValue
                    }
                }
            }
        }
                
        return total
    }
    
    private var totalStock: Double {
        var total: Double = 0
        
        for w in wallet {
            if let stock = w.stockWallet {
                if !stock.isEmpty {
                    for s in stock {
                        if !s.stockType.contains("CI") {
                            total += s.totalValue
                        }
                    }
                }
            }
        }
                
        return total
    }
    
    private var totalFunds: Double {
        var total: Double = 0
        
        for w in wallet {
            if let stock = w.stockWallet {
                if !stock.isEmpty {
                    for s in stock {
                        if s.stockType.contains("CI") {
                            total += s.totalValue
                        }
                    }
                }
            }
        }
                
        return total
    }
}

