//
//  WelcomeViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class WelcomeViewModel: WelcomeViewModelProtocol {
    
    weak var view: WelcomeViewProtocol?
    private var coordinator: WelcomeCoordinatorProtocol?
    
    init(coordinator: WelcomeCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func registerScreen() {
        coordinator?.coordinateToRegister()
    }
    
    func loginScreen() {
        coordinator?.coordinateToLogin()
    }
}
