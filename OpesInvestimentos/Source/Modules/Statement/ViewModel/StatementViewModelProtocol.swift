//
//  StatementViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol StatementViewModelProtocol: class {
    var view: StatementViewProtocol? { get set }
    
    func loadStatement() -> StatementViewDataProtocol
}

protocol StatementViewModelDelegate: class {
    func onLoadStatement(error: FirebaseError?)
}
