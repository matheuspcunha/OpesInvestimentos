//
//  WelcomeViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol WelcomeViewModelProtocol: class {
    var view: WelcomeViewProtocol? { get set }
    
    func registerScreen()
    func loginScreen()
}
