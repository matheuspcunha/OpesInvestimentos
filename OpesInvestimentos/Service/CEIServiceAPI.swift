//
//  APICEI.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 30/05/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case taskError
    case invalidResponse
    case invalidStatusCode(Int)
    case noData
    case invalidJSON
}

enum RESTOperation: String {
    case stockHistory = "stockHistory"
    case dividends = "dividends"
    case wallet = "wallet"
}

final class CEIServiceAPI {
    
    // MARK: - Properties
    
    private static let basePath = "https://api-cei.rj.r.appspot.com/"
    
    private static let session = URLSession(configuration: configuration)
    
    private static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.allowsCellularAccess = true
        configuration.httpMaximumConnectionsPerHost = 6
        return configuration
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    // MARK: - Methods
    
    private init() {}
    
    static func getDividends(params: [String: String],
                             onComplete: @escaping (Result<Bool, APIError>) -> Void) {
        
        guard let url = URL(string: "\(basePath)\(RESTOperation.dividends)") else {
            return onComplete(.failure(.invalidURL))
        }
        
        let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return onComplete(.failure(.taskError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.invalidResponse))
            }
            
            if response.statusCode != 200 {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noData))
            }
            
            do {
                let _ = try decoder.decode([Dividends].self, from: data)
                onComplete(.success(true))
            } catch {
                onComplete(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
    
    static func getStockHistory(params: [String: String],
                                onComplete: @escaping (Result<Bool, APIError>)->Void) {
        
        guard let url = URL(string: "\(basePath)\(RESTOperation.stockHistory)") else {
            onComplete(.failure(.invalidURL))
            return
        }
        
        let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return onComplete(.failure(.taskError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.invalidResponse))
            }
            
            if response.statusCode != 200 {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noData))
            }
            
            do {
                _ = try decoder.decode([History].self, from: data)
                onComplete(.success(true))
            } catch {
                onComplete(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
    
    static func getWallet(params: [String: String],
                          onComplete: @escaping (Result<Bool, APIError>) -> Void) {
        
        guard let url = URL(string: "\(basePath)\(RESTOperation.wallet)") else {
            return onComplete(.failure(.invalidURL))
        }
        
        let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return onComplete(.failure(.taskError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.invalidResponse))
            }
            
            if response.statusCode != 200 {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noData))
            }
            
            do {
                _ = try decoder.decode([Wallet].self, from: data)
                onComplete(.success(true))
            } catch {
                onComplete(.failure(.invalidJSON))
            }
        }
        task.resume()
    }
    
    static func testGetStockHistory() -> [History.StockHistory]? {
        guard let jsonURL = Bundle.main.url(forResource: "history", withExtension: "json") else {return nil}
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
             let history = try decoder.decode([History].self, from: jsonData)
            
            var stocks: [History.StockHistory] = []
            for h in history {
                guard let stock = h.stockHistory else {continue}
                stocks.append(contentsOf: stock)
            }
            
            return stocks
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func testGetDividends() -> [Dividends]? {
        guard let jsonURL = Bundle.main.url(forResource: "dividends", withExtension: "json") else {return nil}
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            return try decoder.decode([Dividends].self, from: jsonData)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func testGetWallet() -> [Wallet]? {
        guard let jsonURL = Bundle.main.url(forResource: "wallet", withExtension: "json") else {return nil}
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            return try decoder.decode([Wallet].self, from: jsonData)
        } catch {
            print(error)
        }
        
        return nil
    }
}
