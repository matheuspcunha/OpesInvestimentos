//
//  PricesCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct PricesCellBuilder: TableViewCellBuilder {
    
    let price: Price
    let asset: InvestimentAsset
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(PricesCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: PricesCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(price: price, asset: asset)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
