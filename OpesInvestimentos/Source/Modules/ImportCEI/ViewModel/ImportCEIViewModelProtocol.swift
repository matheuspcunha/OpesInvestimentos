//
//  ImportCEIViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol ImportCEIViewModelProtocol: class {
    var view: ImportCEIViewProtocol? { get set }
    var viewData: ImportCEIViewDataProtocol { get set }
    
    func importFromCEI(password: String?)
    func forgotPassword()
    func backScreen()
}
