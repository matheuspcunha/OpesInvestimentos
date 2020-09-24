//
//  AssetCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct AssetCellBuilder: TableViewCellBuilder {
    
    let asset: InvestimentAsset
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(AssetCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: AssetCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(asset: asset)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
