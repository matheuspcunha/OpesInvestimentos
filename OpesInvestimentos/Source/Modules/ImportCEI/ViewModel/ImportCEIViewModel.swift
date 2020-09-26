//
//  ImportCEIViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import KeychainSwift

final class ImportCEIViewModel: ImportCEIViewModelProtocol {

    var view: ImportCEIViewProtocol?
    var viewData: ImportCEIViewDataProtocol
    
    private var service: ImportCEIServiceProtocol
    private var coordinator: ImportCEICoordinatorProtocol?
    private var userStorage: UserStorage

    init(coordinator: ImportCEICoordinatorProtocol?,
         service: ImportCEIServiceProtocol = ImportCEIService(),
         userStorage: UserStorage = KeychainSwift()) {
        self.coordinator = coordinator
        self.service = service
        self.userStorage = userStorage
        self.viewData = ImportCEIViewData(cpf: userStorage.cpf ?? "")
    }
    
    func importFromCEI(password: String?) {
        guard let password = password,
              let userID = FirebaseService.currentUser?.uid else { return }
        
        if password.isEmpty {
            print("Campo vázio")
            return
        }

        let params = [ "username":"\(self.viewData.cpf)",
                       "password":"\(password)",
                       "id":"\(userID)" ]

        importCEI(params)
    }
    
    func forgotPassword() {
        coordinator?.openCEIWebsite()
    }
    
    func backScreen() {
        coordinator?.back()
    }
    
    private func importCEI(_ params: [String: String]) {
        coordinator?.showLoading(true)
        service.getWallet(params: params) { [weak self] (result) in
            switch result {
            case .success:
                self?.getStatement(params)
            case .failure(let err):
                self?.coordinator?.showLoading(false)
                print(err)
            }
        }
    }
    
    private func getStatement(_ params: [String: String]) {
        coordinator?.showLoading(true) 
        service.getStatement(params: params) { [weak self] (result) in
        self?.coordinator?.showLoading(false)
            switch result {
            case .success:
                self?.coordinator?.coordinateToTabBar()
            case .failure(let err):
                print(err)
            }
        }
    }
}
