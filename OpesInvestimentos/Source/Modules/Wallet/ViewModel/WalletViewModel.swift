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
    weak var delegate: WalletViewModelDelegate?
    private var coordinator: WalletCoordinatorProtocol?
    
    var viewData: WalletViewDataProtocol? {
        didSet {
            delegate?.onLoadWallet()
        }
    }
    
    init(coordinator: WalletCoordinatorProtocol?) {
        self.coordinator = coordinator
    }

    func loadWallet() {
        FirebaseService.getData(collection: .wallet) { (query, error) in
            guard let query = query, error == nil else { return }

            var wallet: [Wallet] = []
            for document in query.documents {
                let data = document.data()
                wallet.append(Wallet(dictionary: data))
            }

            self.viewData = WalletViewData(name: "Teste",
                                           investiments: self.parseInvestiments(in: wallet))
        }
    }
    
    private func parseInvestiments(in wallet: [Wallet]) -> [Investiment] {
        var totalFunds: Double = 0
        var totalStock: Double = 0
        var totalTreasury: Double = 0

        for w in wallet {
            if let stock = w.stockWallet {
                if !stock.isEmpty {
                    for s in stock {
                        if s.stockType.contains("CI") {
                            totalFunds += s.totalValue
                        } else {
                            totalStock += s.totalValue
                        }
                    }
                }
            }
            if let treasure = w.nationalTreasuryWallet {
                if !treasure.isEmpty {
                    for t in treasure {
                        totalTreasury += t.grossValue
                    }
                }
            }
        }

        return [Investiment(type: .funds, value: totalFunds),
                Investiment(type: .stock, value: totalStock),
                Investiment(type: .treasure, value: totalTreasury)]
    }
}

