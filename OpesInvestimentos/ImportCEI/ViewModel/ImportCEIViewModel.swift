//
//  ImportCEIViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol ImportCEIViewModelDelegate: class {
    func onImport(result: Result<Bool, APIError>)
}

class ImportCEIViewModel {
    
    // MARK: - Properties
    
    private final let MAX_ATTEMPT: Int = 2

    weak var delegate: ImportCEIViewModelDelegate?
    
    private var attemptsCounter: Int = 0
    
    private var cpf: String = "" {
        didSet { cpfLoaded?() }
    }
    
    var userCPF: String {
        return self.cpf
    }
    
    var cpfLoaded: (()->Void)?
    
    // MARK: - Methods
    
    init() {
        self.getUserCPF()
    }

    func importFromCEI(password: String) {
        if password.isEmpty {
            print("Campo vázio")
            return
        }
        
        let params = [ "username":"\(self.cpf.onlyNumbers())", "password":"\(password)" ]
        if(Defaults.lastUpdateWallet == nil) {
            self.getWallet(params)
        } else if (Defaults.lastUpdateDividend == nil) {
            self.getDividends(params)
        } else if (Defaults.lastUpdateHistory == nil) {
            self.getStockHistory(params)
        } else {
            print("Já adicionados, só atualizar")
        }
    }

    private func getUserCPF() {
        FirebaseService.getUserInfo() { (user, error) in
            guard let user = user, error == nil else { return }
            self.cpf = user.cpf.cpfFormat()
        }
    }
    
    private func getWallet(_ params: [String: String]) {
        CEIServiceAPI.getWallet(params: params, onComplete: { [weak self] (result) in
            guard let self = self else {return}

            switch result {
            case .success:
                self.delegate?.onImport(result: .success(true))
                self.attemptsCounter = 0
                Defaults.lastUpdateWallet = Date()
                self.getDividends(params)
                
            case .failure(let err):
                if self.attemptsCounter < self.MAX_ATTEMPT {
                    self.getWallet(params)
                    self.attemptsCounter += 1
                    print("Retry getWallet: \(self.attemptsCounter)")
                 } else {
                    self.delegate?.onImport(result: .failure(err))
                }
                break
            }
        })
    }
    
    private func getDividends(_ params: [String: String]) {
        CEIServiceAPI.getDividends(params: params, onComplete: { [weak self] (result) in
            guard let self = self else {return}

            switch result {
            case .success:
                self.attemptsCounter = 0
                Defaults.lastUpdateDividend = Date()
                self.getStockHistory(params)
                
            case .failure(let err):
                if self.attemptsCounter < self.MAX_ATTEMPT {
                    self.getDividends(params)
                    self.attemptsCounter += 1
                    print("Retry getDividends: \(self.attemptsCounter)")
                 } else {
                    self.delegate?.onImport(result: .failure(err))
                }
                break
            }
        })
    }
    
    private func getStockHistory(_ params: [String: String]) {
        CEIServiceAPI.getStockHistory(params: params, onComplete: { [weak self] (result) in
            guard let self = self else {return}

            switch result {
            case .success:
                Defaults.lastUpdateHistory = Date()
                self.delegate?.onImport(result: .success(true))
                
            case .failure(let err):
                if self.attemptsCounter < self.MAX_ATTEMPT {
                    self.getStockHistory(params)
                    self.attemptsCounter += 1
                    print("Retry getStockHistory: \(self.attemptsCounter)")
                 } else {
                    self.delegate?.onImport(result: .failure(err))
                }
                break
            }
        })
    }
}
