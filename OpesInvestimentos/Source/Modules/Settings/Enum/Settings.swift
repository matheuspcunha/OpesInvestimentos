//
//  Settings.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum Settings: String, CaseIterable {

    case account = "Account"
    case exit = "Exit"
    
    var title: String {
        switch self {
        case .exit:
            return "Sair"
        case .account:
            return "Minha Conta"
        }
    }
    
    var color: UIColor {
        switch self {
        case .exit:
            return .red
        default:
            return .darkGray
        }
    }
}
