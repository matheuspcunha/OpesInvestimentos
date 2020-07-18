//
//  LoginViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func onLoginUser(result: Result<Bool, FirebaseError>)
}

class LoginViewModel {
    
    // MARK: - Properties
    
    weak var delegate: LoginViewModelDelegate?

    // MARK: - Methods
    
    func login(withEmail email: String, password: String) {
        FirebaseService.login(withEmail: email, password: password) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success:
                self.delegate?.onLoginUser(result: .success(true))
            case .failure(let error):
                self.delegate?.onLoginUser(result: .failure(error))
            }
        }
    }
}
