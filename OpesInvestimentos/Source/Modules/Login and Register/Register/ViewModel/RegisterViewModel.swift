//
//  RegisterViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class RegisterViewModel: RegisterViewModelProtocol {
    
    weak var view: RegisterViewProtocol?
    private var coordinator: RegisterCoordinatorProtocol?
    
    init(coordinator: RegisterCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func register(name: String?, cpf: String?, email: String?,
                  password: String?, confirmpassword: String?) {
        guard let name = name, let cpf = cpf,
              let email = email,
              let password = password,
              let confirmpassword = confirmpassword
        else {return}
        
        let info = ["name":  name,
                    "cpf": cpf,
                    "email": email,
                    "password": password,
                    "confirmPassword": confirmpassword ]
        
        if infoIsValid(fields: info) {
            FirebaseService.register(email: email, withPassword: password) { [weak self] (result) in
                guard let self = self else {return}
                            
                switch result {
                case .success:
                    Defaults.shared.cpf = cpf
                    FirebaseService.updateUserName(name: name)
                    self.login(withEmail: email, password: password)
                case .failure(let error):
                    self.coordinator?.showAlert(Alert.show(title: error.title, message: error.message))
                }
            }
        }
    }
    
    private func login(withEmail email: String, password: String) {
        FirebaseService.login(withEmail: email, password: password) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.coordinator?.coordinateToImportCEI()
            case .failure(let error):
                self.coordinator?.showAlert(Alert.show(title: error.title, message: error.message))
            }
        }
    }
    
    private func infoIsValid(fields: [String : String]) -> Bool {
        let cpf = fields["cpf"]
        let password = fields["password"]
        let confirmPassword = fields["confirmPassword"]
        
        if !checkFieldsFilled(fields) {
            self.coordinator?.showAlert(Alert.show(title: FirebaseError.emptyField.title, message: FirebaseError.emptyField.message))

            return false
        } else if !password!.elementsEqual(confirmPassword!) {
            print("Senhas não conferem")
            return false
        } else if !cpf!.isCPF {
            self.coordinator?.showAlert(Alert.show(title: FirebaseError.invalidCPF.title, message: FirebaseError.invalidCPF.message))
            return false
        }
        
        return true
    }
    
    private func checkFieldsFilled(_ fields: [String : String]) -> Bool {
        for field in fields {
            if field.value.isEmpty {
                return false
            }
        }

        return true
    }
    
    func backScreen() {
        coordinator?.back()
    }
}
