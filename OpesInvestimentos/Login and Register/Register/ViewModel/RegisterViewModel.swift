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
    
    private var user: User?
    weak var delegate: RegisterViewModelDelegate?

    // MARK: - Methods
    
    func register(name: String, cpf: String, email: String, password: String, confirmpassword: String) {

        if !self.validateUserInfo(name, cpf, email, password, confirmpassword) {
            return
        }

        FirebaseService.register(email: email, password: password) { [weak self] (result) in
            guard let self = self else {return}
                        
            switch result {
            case .success:
                self.storeUserInfo(name, cpf, email)
            case .failure(let error):
                self.delegate?.onRegisterUser(result: .failure(error))
            }
        }
    }
    
    private func storeUserInfo(_ name: String, _ cpf: String, _ email: String) {
        let uid = FirebaseService.currentUser?.uid
        self.user = User(id: uid!, name: name, cpf: cpf, email: email)
        
        guard let userId = self.user?.id, let userData = self.user?.toData() else { return }
        
        FirebaseService.addUser(id: userId, data: userData) { [weak self] (result) in
            guard let self = self else {return}

            switch result {
            case .success:
                self.delegate?.onRegisterUser(result: .success(true))
            case .failure(let error):
                self.delegate?.onRegisterUser(result: .failure(error))
            }
        }
    }
    
    private func validateUserInfo(_ name: String, _ cpf: String, _ email: String, _ password: String, _ confirmpassword: String) -> Bool {
        if name.isEmpty || cpf.isEmpty || email.isEmpty || password.isEmpty || confirmpassword.isEmpty {
            self.delegate?.onRegisterUser(result: .failure(FirebaseError.emptyField))
            return false
        } else if !password.elementsEqual(confirmpassword) {
            print("Senhas não conferem")
        } else if !cpf.isCPF {
            self.delegate?.onRegisterUser(result: .failure(FirebaseError.invalidCPF))
            return false
        }
        
        return true
    }
}
