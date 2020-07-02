//
//  Formatter.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 09/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class Formatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
}
