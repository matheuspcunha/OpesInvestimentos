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
    
    private var filteredStatement: [Statement] = [] {
        didSet {
            statementFiltered?()
        }
    }

    var statementLoaded: (()->Void)?
    
    var statementFiltered: (()->Void)?

    weak var delegate: StatementViewModelDelegate?

    var count: Int { return statement.count }
    
    var filteredCount: Int { return filteredStatement.count }

    // MARK: - Methods

    func loadStatement() {
        FirebaseService.getData(collection: .statement) { (query, error) in
            var statement:[Statement] = []
            
            guard let query = query, error == nil else {
                self.statementLoaded?()
                return
            }
            
            for document in query.documents {
                var data: [String : Any] = document.data()
                data["id"] = document.documentID
                statement.append(Statement(dictionary: data))
            }

            statement.sort(by: { $0.date > $1.date})
            self.statement = statement
        }
    }

    func getStatement(at indexPath: IndexPath, filter: Bool) -> Statement {
        return filter ? filteredStatement[indexPath.row] : statement[indexPath.row]
    }
    
    func cellViewModelFor(indexPath: IndexPath, filter: Bool) -> StatementCellViewModel {
        let statement = getStatement(at: indexPath, filter: filter)
        return StatementCellViewModel(statement: statement)
    }
    
    func delete(indexPath: IndexPath, filter: Bool, onComplete: @escaping (Result<Bool, FirebaseError>)->Void) {
        let statement = getStatement(at: indexPath, filter: filter)
        guard let id = statement.id else {return}
        
        FirebaseService.deleteData(in: .statement, id: id) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success:
                if filter {
                    self.filteredStatement.remove(at: indexPath.row)
                } else {
                    self.statement.remove(at: indexPath.row)
                }
            case .failure:
                break
            }
            
            onComplete(result)
        }
    }
    
    func filterContentForSearchText(_ searchText: String?, operation: Operation? = nil) {
        filteredStatement = statement.filter { (statement: Statement) -> Bool in
            let doesOperationMatch = operation == .Todos || statement.type == operation
            
            guard let text = searchText, !text.isEmpty else {
                return doesOperationMatch
            }
            
            return doesOperationMatch && statement.code.lowercased().contains(text.lowercased())
        }

        statementFiltered?()
    }
}
