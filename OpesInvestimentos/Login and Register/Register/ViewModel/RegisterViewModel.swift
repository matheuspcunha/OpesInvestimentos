//
//  RegisterViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol RegisterViewModelDelegate: class {
    func onRegisterUser(result: Result<Bool, FirebaseError>)
}

class RegisterViewModel {
    
    // MARK: - Properties
    
    weak var delegate: RegisterViewModelDelegate?

    // MARK: - Methods
    
    func register(name: String, cpf: String, email: String,
                  password: String, confirmpassword: String) {
                
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
                    let uid = FirebaseService.currentUser?.uid
                    let user = User(id: uid!, name: name, cpf: cpf, email: email)
                    
                    FirebaseService.setUserInfo(data: user.toData())
                    self.delegate?.onRegisterUser(result: .success(true))
                case .failure(let error):
                    self.delegate?.onRegisterUser(result: .failure(error))
                }
            }
        }
    }
    
    private func infoIsValid(fields: [String : String]) -> Bool {
        
        let cpf = fields["cpf"]
        let password = fields["password"]
        let confirmPassword = fields["confirmPassword"]
        
        if !checkFieldsFilled(fields) {
            self.delegate?.onRegisterUser(result: .failure(FirebaseError.emptyField))
            return false
        } else if !password!.elementsEqual(confirmPassword!) {
            print("Senhas não conferem")
            return false
        } else if !cpf!.isCPF {
            self.delegate?.onRegisterUser(result: .failure(FirebaseError.invalidCPF))
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
}
