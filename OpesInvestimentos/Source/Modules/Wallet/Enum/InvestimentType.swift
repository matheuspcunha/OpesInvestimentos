//
//  InvestimentType.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum InvestimentType {
    case treasure, funds, stock
}

extension InvestimentType {
    
    var color: UIColor {
        switch self {
        case .treasure:
            return .appTreasure
        case .funds:
            return .appFund
        case .stock:
            return .appStock
        }
    }
    
    var name: String {
        switch self {
        case .treasure:
            return "Tesouro Direto"
        case .funds:
            return "Fundos"
        case .stock:
            return "Ações"
        }
    }
}

