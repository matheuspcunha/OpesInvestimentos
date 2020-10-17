//
//  AlphaVantageServiceAPI.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class AlphaVantageServiceAPI {

    enum Endpoints {
        static let base = "https://www.alphavantage.co/query"
        static let apiKey = "32D2R6JWK0F7JZKM"
        
        case day(stock: String)
        case week(stock: String)
        case month(stock: String)
        
        var stringValue: String {
            switch self {
                case .day(let stock):
                    return "\(Endpoints.base)?function=TIME_SERIES_DAILY&symbol=\(stock).SA&apikey=\(Endpoints.apiKey)"
                case .week(let stock):
                    return "\(Endpoints.base)?function=TIME_SERIES_WEEKLY&symbol=\(stock).SA&apikey=\(Endpoints.apiKey)"
                case .month(let stock):
                    return "\(Endpoints.base)?function=TIME_SERIES_MONTHLY&symbol=\(stock).SA&apikey=\(Endpoints.apiKey)"
            }
        }
    }
    
    func getPricesForTheDay(stock: String, onComplete: @escaping (Result<[Price], Error>) -> Void) {
        let url = Endpoints.day(stock: stock).stringValue
        handleRequest(url: url, parseKey: "Time Series (Daily)", completion: onComplete)
    }
    
    func getPricesForTheWeek(stock: String, onComplete: @escaping (Result<[Price], Error>) -> Void) {
        let url = Endpoints.week(stock: stock).stringValue
        handleRequest(url: url, parseKey: "Weekly Time Series", completion: onComplete)
    }
    
    func getPricesForTheMonth(stock: String, onComplete: @escaping (Result<[Price], Error>) -> Void) {
        let url = Endpoints.month(stock: stock).stringValue
        handleRequest(url: url, parseKey: "Monthly Time Series", completion: onComplete)
    }
    
    func mock(stock: String, onComplete: @escaping (Result<[Price], Error>) -> Void) {
        let url = Endpoints.day(stock: stock).stringValue
        test(url: url, parseKey: "Time Series (Daily)", completion: onComplete)
    }
    
    private func handleRequest(url: String, parseKey: String, completion: @escaping (Result<[Price], Error>) -> Void) {
        AF.request(url).responseJSON() { response in
            switch response.result {
                case .success(let data):
                    let prices = self.parseResponse(data: data, parseKey: parseKey)
                    completion(.success(prices))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
    private func test(url: String, parseKey: String, completion: @escaping (Result<[Price], Error>) -> Void) {
        guard let jsonURL = Bundle.main.url(forResource: "alpha", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let prices = self.parseResponse(data: data, parseKey: parseKey)
            completion(.success(prices))
        } catch (let error) {
            completion(.failure(error))
        }
    }
    
    private func parseResponse(data: Any, parseKey: String) -> [Price] {
        let resp = JSON(data)
        let priceTimes = resp[parseKey]
        var prices: [Price] = []
        for (date, val) in priceTimes {
            let price = Price(data: val, date: date)
            prices.append(price)
        }
        return prices
    }
}
