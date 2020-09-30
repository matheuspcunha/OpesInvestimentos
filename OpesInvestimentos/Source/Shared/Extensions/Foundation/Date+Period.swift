//
//  Date+Period.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 29/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

extension Date {
    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }

    func getLast3Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)
    }
    
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }
}
