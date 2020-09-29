//
//  LoginViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    
    weak var view: LoginViewProtocol?
    private var coordinator: LoginCoordinatorProtocol?
    
    init(coordinator: LoginCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func login(withEmail email: String?, password: String?) {
        if let email = email, let password = password {
            if (!email.isEmpty || !password.isEmpty) {
                FirebaseService.login(withEmail: email, password: password) { [weak self] (result) in
                    guard let self = self else {return}

                    switch result {
                    case .success:
                        FirebaseService.checkIfExist(collection: .wallet) { (result) in
                            if result {
                                self.coordinator?.coordinateToTabBar()
                            } else {
                                self.coordinator?.coordinateToImportCEI()
                            }
                        }
                    case .failure(let error):
                        self.coordinator?.showAlert(Alert.make(title: error.title, message: error.message))
                    }
                }
            } else {
                coordinator?.showAlert(Alert.make(title: "Test", message: "Campo Vazio"))
            }
        }
    }

    func forgotPassword() {
        coordinator?.coordinateToForgotPassword()
    }
    
    func backScreen() {
        coordinator?.back()
    }
}
