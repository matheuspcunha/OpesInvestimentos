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
            coordinator?.showLoading(false)
            delegate?.onLoadWallet()
        }
    }
    
    init(coordinator: WalletCoordinatorProtocol?) {
        self.coordinator = coordinator
    }

    func loadWallet() {
        coordinator?.showLoading(true)

        var statement:[Statement] = []
        var wallet: [Wallet] = []
        
        FirebaseService.getData(collection: .wallet) { (query, error) in
            guard let query = query, error == nil else { return }

            for document in query.documents {
                let data = document.data()
                wallet.append(Wallet(dictionary: data))
            }
        }
        
        FirebaseService.getData(collection: .statement) { (query, error) in
            guard let query = query, error == nil else { return }
            
            for document in query.documents {
                var data: [String : Any] = document.data()
                data["id"] = document.documentID
                statement.append(Statement(dictionary: data))
            }
            
            let investments = self.parseInvestiments(in: wallet)
            let totalCost = self.parseTotalCost(statement: statement,
                                                investiments: investments)
            self.viewData = WalletViewData(investiments: investments,
                                           name: "Tester",
                                           totalCost: totalCost)
        }
    }
    
    private func parseInvestiments(in wallet: [Wallet]) -> [Investiment] {
        var funds = [InvestimentAsset]()
        var stocks = [InvestimentAsset]()
        var treasures = [InvestimentAsset]()

        for w in wallet {
            if let stock = w.stockWallet {
                for s in stock {
                    if s.stockType.contains("CI") {
                        funds.append(InvestimentAsset(symbol: s.code, name: s.company, price: s.price, quantity: s.quantity, total: s.totalValue))
                    } else {
                        stocks.append(InvestimentAsset(symbol: s.code, name: s.company, price: s.price, quantity: s.quantity, total: s.totalValue))
                    }
                }
            }
            if let treasure = w.nationalTreasuryWallet {
                for t in treasure {
                    treasures.append(InvestimentAsset(symbol: t.code, name: t.code, price: 0, quantity: 0, total: t.grossValue))
                }
            }
        }

        return [Investiment(type: .funds, assets: funds),
                Investiment(type: .stock, assets: stocks),
                Investiment(type: .treasure, assets: treasures)]
    }
    
    private func parseTotalCost(statement: [Statement], investiments: [Investiment]) -> Double {
        var total: Double = 0
        var assets = [InvestimentAsset]()

        investiments.forEach { (investiment) in
            assets.append(contentsOf: investiment.assets)
        }

        for s in statement.filter({$0.type == .compra}) {
            if assets.contains(where: {$0.symbol == s.code}) {
                total += s.total
            }
        }

        return total
    }
}

