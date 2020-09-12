//
//  StatementViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class StatementViewModel: StatementViewModelProtocol {

    var view: StatementViewProtocol?
    private var coordinator: StatementCoordinatorProtocol?

    init(coordinator: StatementCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func loadStatement() -> StatementViewDataProtocol {
//        FirebaseService.getData(collection: .statement) { (query, error) in
//            var statement:[Statement] = []
//            
//            guard let query = query, error == nil else {
//                self.statementLoaded?()
//                return
//            }
//            
//            for document in query.documents {
//                var data: [String : Any] = document.data()
//                data["id"] = document.documentID
//                statement.append(Statement(dictionary: data))
//            }
//        }

        return StatementViewData(operations: mock())
    }
    
    func mock() -> [Statement] {
        var statement: [Statement] = []
        var n = 10
        let dates = [Date().dayAfter, Date().dayBefore, Date().dayBeforeBefore]
        
        while n > 0 {
            statement.append(Statement(id: String(n), date: dates.randomElement()!, operation: "Testando",
                                       code: "T3ST", quantity: Int.random(in: 1...100),
                                       price: Double.random(in: 1...100),
                                       total: Double.random(in: 1...100)))
            n-=1
        }
        
        return statement
    }
}

extension Date {

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayBeforeBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
