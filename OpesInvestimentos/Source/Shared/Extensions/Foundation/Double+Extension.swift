//
//  Double+Extension.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

extension Double {

    private func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        guard let formatted = formatter.string(from: self as NSNumber) else {
            return String(self)
        }
        return formatted
    }
    
    private func formatAsCurrencyNoSymbol() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        guard let formatted = formatter.string(from: self as NSNumber) else {
            return String(self)
        }
        return formatted
    }
    
    private func formatAsPercent() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        guard let formatted = formatter.string(from: self as NSNumber) else {
            return String(self)
        }
        return formatted
    }
    
    func formatCurrency(emptyIfZero: Bool = false, symbol: Bool = true) -> String {
        if self.isZero, emptyIfZero {
            return "R$ --"
        }
        return symbol ? self.formatAsCurrency() : self.formatAsCurrencyNoSymbol()
    }
    
    func formatPercent(emptyIfZero: Bool = false) -> String {
        if self.isZero, emptyIfZero {
            return "--%"
        }
        return self.formatAsPercent()
    }
}

extension Optional where Wrapped == Double {
    func formatCurrency(emptyIfZero: Bool = false) -> String {
        switch self {
        case .none: return "R$ --"
        case .some(let value): return value.formatCurrency(emptyIfZero: emptyIfZero)
        }
    }
    
    func formatPercent(emptyIfZero: Bool = false) -> String {
        switch self {
        case .none: return "--%"
        case .some(let value): return value.formatPercent(emptyIfZero: emptyIfZero)
        }
    }
}
