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
    case statement = "statement"
    case walletTest = "walletTest"
    case statementTest = "statementTest"
}

final class CEIServiceAPI {
    
    private let basePath = "https://api-cei.rj.r.appspot.com/"
    
    private let session: URLSession
    
    private let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.allowsCellularAccess = true
        configuration.httpMaximumConnectionsPerHost = 6
        return configuration
    }()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    init() {
        self.session = URLSession(configuration: configuration)
    }
    
    func request(with params: [String: String],
                 operation: RESTOperation,
                 onComplete: @escaping (Result<Bool, APIError>)->Void) {
        
        guard let url = URL(string: "\(basePath)\(operation)") else {
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
            
            guard data != nil else {
                return onComplete(.failure(.noData))
            }
            
            do {
                onComplete(.success(true))
            } catch {
                onComplete(.failure(.invalidJSON))
            }
        }

        task.resume()
    }
    
    func requestTest() {
        
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=PETR4.SA&apikey=32D2R6JWK0F7JZKM") else {
            print("invalidURL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                print("taskError")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("invalidResponse")
                return
            }
            
            if response.statusCode != 200 {
                print(response.statusCode)

            }
            
            guard let data = data else {
                print("noData")
                return
            }
            
            
            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // try to read out a string array
                        print(json)
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
