//
//  WalletViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class WalletViewModel: WalletViewModelProtocol {
    
    weak var view: WalletViewProtocol?
    private var coordinator: WalletCoordinatorProtocol?
    
    init(coordinator: WalletCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    private var wallet: [Wallet] = []
    
    weak var delegate: WalletViewModelDelegate?
    
    var walletLoaded: (()->Void)?
    
    // MARK: - Methods

    func loadWallet() {
        FirebaseService.getData(collection: .wallet) { (query, error) in
            guard let query = query, error == nil else {
                self.walletLoaded?()
                return
            }

            self.wallet.removeAll()
            for document in query.documents {
                let data = document.data()
                self.wallet.append(Wallet(dictionary: data))
            }
        }
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
                
        return 5
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
                
        return 5
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
                
        return 5
    }
}

