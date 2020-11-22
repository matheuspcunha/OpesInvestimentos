//
//  InvestimentDetailsViewDataProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

protocol InvestimentDetailsViewDataProtocol {
    var asset: InvestimentAsset { get }
    var amountInvested: Double { get }
    var appreciation: Double { get }
    var yielded: Double { get }
}
