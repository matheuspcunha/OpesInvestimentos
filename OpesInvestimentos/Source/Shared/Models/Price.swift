//
//  Price.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Price: Codable {
    let open: Double
    let close: Double
    let low: Double
    let high: Double
    let volume: Double?
    let date: Date
    
    init(data: JSON, date: String) {
        open = Double(data["1. open"].string ?? "") ?? 0
        close = Double(data["4. close"].string ?? "") ?? 0
        low = Double(data["3. low"].string ?? "") ?? 0
        high = Double(data["2. high"].string ?? "") ?? 0
        volume = Double(data["5. volume"].string ?? "") ?? 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.date(from: date) ?? Date()
    }

    enum CodingKeys: String, CodingKey {
        case open = "o"
        case close = "c"
        case low = "l"
        case high = "h"
        case volume = "v"
        case date
    }
}
