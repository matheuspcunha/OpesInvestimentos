//
//  RegisterViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class RegisterViewModel {
    
    private var user: User?
    
    func register(name: String, cpf: String, email: String, password: String) {
        
        // TODO: Validar campos CPF e Senha
        
        FirebaseService.register(email: email, password: password) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success( _):
                print("Usuário registrado! 👍")
                self.user = User(id: FirebaseService.currentUser!.uid, name: name, cpf: cpf, email: email)
                self.registerUserInfo()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func registerUserInfo() {
        guard let id = user?.id, let userData = user?.toData() else { return }
        FirebaseService.AddToCollection(collection: DBCollection.userInfo, id: id, data: userData)
    }
}
