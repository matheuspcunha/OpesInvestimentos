//
//  StockTimesSeries.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 15/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

struct StockTimesSeries: Decodable {
    let metaData: StockMetaData
}

struct StockMetaData: Decodable {
    let symbol: String
    let lastRefreshed: Date
}

struct DailyPrice: Decodable {
    let symbol: String
    let lastRefreshed: Date
}
