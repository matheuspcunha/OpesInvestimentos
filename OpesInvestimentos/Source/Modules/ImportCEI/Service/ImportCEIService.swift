//
//  ImportCEIService.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 14/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol ImportCEIServiceProtocol {
    func getWallet(params: [String: String], onComplete: @escaping (Result<Bool, APIError>) -> Void)
    func getStatement(params: [String: String], onComplete: @escaping (Result<Bool, APIError>) -> Void)
}

struct ImportCEIService: ImportCEIServiceProtocol {
    
    private let network: CEIServiceAPI
    
    init(network: CEIServiceAPI = CEIServiceAPI()) {
        self.network = network
    }

    func getWallet(params: [String : String], onComplete: @escaping (Result<Bool, APIError>) -> Void) {
        network.request(with: params, operation: .walletTest) { (result) in
            switch result {
            case .success:
                onComplete(result)
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    func getStatement(params: [String : String], onComplete: @escaping (Result<Bool, APIError>) -> Void) {
        network.request(with: params, operation: .statementTest) { (result) in
            switch result {
            case .success:
                onComplete(result)
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
