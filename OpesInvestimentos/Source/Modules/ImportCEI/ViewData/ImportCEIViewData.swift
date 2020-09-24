//
//  ImportCEIViewData.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct ImportCEIViewData: ImportCEIViewDataProtocol {
    var cpf: String
    
    init(cpf: String) {
        self.cpf = cpf
    }
}
