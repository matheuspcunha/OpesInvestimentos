//
//  LoginViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

enum AppStatus: Int {
    case ready = 1
    case pendingActivation = 2
}

protocol LoginViewModelDelegate: class {
    func onLoginUser(result: Result<AppStatus, FirebaseError>)
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
                FirebaseService.checkIfExist(collection: .wallet) { (result) in
                    if result {
                        self.delegate?.onLoginUser(result: .success(.ready))
                    } else {
                        self.delegate?.onLoginUser(result: .success(.pendingActivation))
                    }
                }
            case .failure(let error):
                self.delegate?.onLoginUser(result: .failure(error))
            }
        }
    }
}
