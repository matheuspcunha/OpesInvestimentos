//
//  RegisterViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol RegisterViewModelProtocol: class {
    var view: RegisterViewProtocol? { get set }
    
    func register(name: String, cpf: String, email: String, password: String, confirmpassword: String)
    func backScreen()
}
