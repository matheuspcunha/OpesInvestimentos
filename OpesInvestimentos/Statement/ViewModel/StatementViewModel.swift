//
//  StatementViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol StatementViewModelDelegate: class {
    func onLoadStatement(error: FirebaseError?)
}

class StatementViewModel {
    
    // MARK: - Properties

    private var statement: [Statement] = [] {
        didSet {
            statementLoaded?()
        }
    }

    var statementLoaded: (()->Void)?
    
    weak var delegate: StatementViewModelDelegate?

    var count: Int { return statement.count }
    
    // MARK: - Methods

    func loadStatement() {
        FirebaseService.getSubCollection(collection: .statement) { (query, error) in
            var statement:[Statement] = []
            
            guard let query = query, error == nil else {
                self.delegate?.onLoadStatement(error: error)
                return
            }
            
            for document in query.documents {
                let data = document.data()
                statement.append(Statement(dictionary: data))
            }
            
            statement.sort(by: { $0.date > $1.date})
            self.statement = statement
        }
    }

    func getStatement(at indexPath: IndexPath) -> Statement {
        return statement[indexPath.row]
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> StatementCellViewModel {
        let statement = getStatement(at: indexPath)
        return StatementCellViewModel(statement: statement)
    }
    
    /*private func updateUserDefaultIfNeeded() {
        if self.count > 0 {
            if Defaults.lastUpdateDividend == nil {
                let dividends = statement.filter({$0.type != .Compra && $0.type != .Venda})
                let mostRecent = dividends.reduce(dividends[0], { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 ? $0 : $1 } )
                Defaults.lastUpdateDividend = mostRecent.date
            }
            
            if Defaults.lastUpdateHistory == nil {
                let history = statement.filter({$0.type == .Compra || $0.type == .Venda})
                let mostRecent = history.reduce(history[0], { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 ? $0 : $1 } )
                Defaults.lastUpdateHistory = mostRecent.date
            }
        }
    }*/
}
