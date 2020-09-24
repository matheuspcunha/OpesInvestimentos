//
//  LoginViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol LoginViewModelProtocol: class {
    var view: LoginViewProtocol? { get set }
    
    func login(withEmail email: String?, password: String?)
    func forgotPassword()
    func backScreen()
}
