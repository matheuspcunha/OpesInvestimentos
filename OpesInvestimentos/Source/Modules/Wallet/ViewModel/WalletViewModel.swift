//
//  WalletViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import KeychainSwift

final class WalletViewModel: WalletViewModelProtocol {
    
    weak var view: WalletViewProtocol?
    weak var delegate: WalletViewModelDelegate?
    
    private var coordinator: WalletCoordinatorProtocol?
    private var service: WalletServiceProtocol
    private var userStorage: UserStorage

    var viewData: WalletViewDataProtocol? {
        didSet {
            coordinator?.showLoading(false)
            delegate?.onLoadWallet()
        }
    }

    init(coordinator: WalletCoordinatorProtocol?,
         service: WalletServiceProtocol = WalletService(),
         userStorage: UserStorage = KeychainSwift()) {
        self.coordinator = coordinator
        self.service = service
        self.userStorage = userStorage
    }

    func loadWallet() {
        coordinator?.showLoading(true)
        
        service.getWallet { (result, error) in
            guard let result = result else { return }

            let investiments = self.parseInvestiments(wallet: result.wallet,
                                                      statement: result.statement)
            let totalCost = self.parseTotalCost(result.statement, investiments)
            let name = self.userStorage.name?.components(separatedBy: " ").first ?? ""

            self.viewData = WalletViewData(investiments: investiments,
                                           name: name,
                                           totalCost: totalCost)
        }
    }
    
    func showDetail(for investiment: Investiment) {
        coordinator?.showInvestimentList(for: investiment)
    }
    
//    private func parseInvestiments(in wallet: [Wallet]) -> [Investiment] {
//        var funds = [InvestimentAsset]()
//        var stocks = [InvestimentAsset]()
//        var treasures = [InvestimentAsset]()
//
//        for w in wallet {
//            if let stock = w.stockWallet {
//                for s in stock {
//                    if s.stockType.contains("CI") {
//                        funds.append(InvestimentAsset(symbol: s.code, name: s.company, price: s.price, quantity: s.quantity, total: s.totalValue, color: .random))
//                    } else {
//                        stocks.append(InvestimentAsset(symbol: s.code, name: s.company, price: s.price, quantity: s.quantity, total: s.totalValue, color: .random))
//                    }
//                }
//            }
//            if let treasure = w.nationalTreasuryWallet {
//                for t in treasure {
//                    treasures.append(InvestimentAsset(symbol: t.code, name: t.code, price: 0, quantity: 0, total: t.grossValue, color: .random))
//                }
//            }
//        }
//
//        return [Investiment(type: .funds, assets: funds),
//                Investiment(type: .stock, assets: stocks),
//                Investiment(type: .treasure, assets: treasures)]
//    }
    
    private func parseInvestiments(wallet: [Wallet],
                                   statement: [Statement]) -> [Investiment] {
        var funds = [InvestimentAsset]()
        var stocks = [InvestimentAsset]()
        var treasures = [InvestimentAsset]()
        
        for w in wallet {
            if let stock = w.stockWallet {
                for s in stock {
                    var total: Double = 0
                    var quantity: Int = 0
                    var received: Double = 0

                    statement.filter({$0.code == s.code}).forEach { statement in
                        switch statement.type {
                        case .compra:
                            total += statement.total
                            quantity += statement.quantity
                        case .venda:
                            total += -statement.total
                            quantity += -statement.quantity
                        case .dividendo, .jurosCapital:
                            received += statement.total
                        default:
                            break
                        }
                    }
                    
                    if s.stockType.contains("CI") {
                        funds.append(InvestimentAsset(symbol: s.code, name: s.company, price: s.price, quantity: s.quantity, total: s.totalValue,
                                                      averagePrice: (total/Double(quantity)), paymentReceived: received, color: .random))
                    } else {
                        stocks.append(InvestimentAsset(symbol: s.code, name: s.company, price: s.price, quantity: s.quantity, total: s.totalValue,
                                                       averagePrice: (total/Double(quantity)), paymentReceived: received, color: .random))
                    }
                }
            }
            if let treasure = w.nationalTreasuryWallet {
                for t in treasure {
                    treasures.append(InvestimentAsset(symbol: t.code, name: t.code, price: 0, quantity: 0,
                                                      total: t.grossValue, averagePrice: 0, paymentReceived: 0, color: .random))
                }
            }
        }
        
        return [Investiment(type: .funds, assets: funds),
                Investiment(type: .stock, assets: stocks),
                Investiment(type: .treasure, assets: treasures)]
    }
    
    private func parseTotalCost(_ statement: [Statement],
                                _ investiments: [Investiment]) -> Double {
        var total: Double = 0
        var assets = [InvestimentAsset]()

        investiments.forEach { investiment in
            assets.append(contentsOf: investiment.assets)
        }

        statement.filter({$0.type == .compra}).forEach { statement in
            if assets.contains(where: {$0.symbol == statement.code}) {
                total += statement.total
            }
        }

        return total
    }
}

