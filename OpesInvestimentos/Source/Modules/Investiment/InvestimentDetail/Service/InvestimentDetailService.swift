//
//  InvestimentDetailService.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol InvestimentDetailServiceProtocol {
    func getPrices(symbol: String, onComplete: @escaping (Result<[Price], Error>) -> Void)
}

struct InvestimentDetailService: InvestimentDetailServiceProtocol {
    
    private let network: AlphaVantageServiceAPI
    
    init(network: AlphaVantageServiceAPI = AlphaVantageServiceAPI()) {
        self.network = network
    }
    
    func getPrices(symbol: String, onComplete: @escaping (Result<[Price], Error>) -> Void) {
        network.mock(stock: symbol) { (result) in
            switch result {
            case .success:
                onComplete(result)
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
