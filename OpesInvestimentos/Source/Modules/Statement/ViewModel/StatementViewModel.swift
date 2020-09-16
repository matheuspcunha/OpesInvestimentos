//
//  StatementViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class StatementViewModel: StatementViewModelProtocol {

    weak var view: StatementViewProtocol?
    weak var delegate: StatementViewModelDelegate?
    private var coordinator: StatementCoordinatorProtocol?

    var viewData: StatementViewDataProtocol? {
        didSet {
            delegate?.onLoadStatement()
        }
    }
    
    init(coordinator: StatementCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func loadStatement() {
        FirebaseService.getData(collection: .statement) { (query, error) in
            var statement:[Statement] = []
            
            guard let query = query, error == nil else { return }
            
            for document in query.documents {
                var data: [String : Any] = document.data()
                data["id"] = document.documentID
                statement.append(Statement(dictionary: data))
            }
            
            self.viewData = StatementViewData(operations: statement)
        }
    }
}
