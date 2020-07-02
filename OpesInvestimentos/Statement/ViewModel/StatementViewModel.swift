//
//  StatementViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class StatementViewModel {
    
    private var statement: [Statement] = [] {
        didSet {
            statementLoaded?()
        }
    }

    var statementLoaded: (()->Void)?
    
    var count: Int { return statement.count }
    
    func loadStatement() {
        statement = []
        for stock in CEIServiceAPI.testGetStockHistory()! {
            self.statement.append(Statement(date: stock.date, operation: stock.operation, code: stock.code, quantity: stock.quantity, price: stock.price, total: stock.totalValue))
        }

        for dividend in CEIServiceAPI.testGetDividends()! {
            let components = Calendar.current.dateComponents([.year], from: Date(), to: dividend.date)
            if (dividend.date <= Date() && components.year! >= 0) {
                self.statement.append(Statement(date: dividend.date, operation: dividend.type, code: dividend.code, quantity: dividend.quantity, price: 0, total: dividend.grossValue))
            }
        }

        /*let params = [ "username":"08922761695", "password":"!*cei12256490*!" ]

        CEIServiceAPI.getStockHistory(params: params, onComplete: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let stocks):
                for stock in stocks {
                    self.statement.append(Statement(date: stock.date, operation: stock.operation, code: stock.code, quantity: stock.quantity, price: stock.price, total: stock.totalValue))
                }
            case .failure(let err):
                print(err)
                self.statementLoaded?()
            }
        })
        
        CEIServiceAPI.getDividends(params: params, onComplete: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let dividends):
                for dividend in dividends {
                    let components = Calendar.current.dateComponents([.year], from: Date(), to: dividend.date)
                    if (dividend.date <= Date() && components.year! >= 0) {
                        self.statement.append(Statement(date: dividend.date, operation: dividend.type, code: dividend.code, quantity: dividend.quantity, price: 0, total: dividend.grossValue))
                    }
                }
            case .failure(let err):
                print(err)
                self.statementLoaded?()
            }
        })*/
        
        statement = statement.filter { $0.type != .Leilao}
        statement.sort(by: { $0.date > $1.date})
    }
    
    func getStatement(at indexPath: IndexPath) -> Statement {
        return statement[indexPath.row]
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> StatementCellViewModel {
        let statement = getStatement(at: indexPath)
        return StatementCellViewModel(statement: statement)
    }
}
