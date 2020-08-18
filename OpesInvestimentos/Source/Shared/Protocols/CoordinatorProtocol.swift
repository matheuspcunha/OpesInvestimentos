//
//  Coordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol CoordinatorProtocol {
    func start()
    func back()
    func coordinate(to coordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {
    func back() {}
    func coordinate(to coordinator: CoordinatorProtocol) {
        coordinator.start()
    }
}
