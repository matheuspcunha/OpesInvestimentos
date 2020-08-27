//
//  ImportCEICoordinatorProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol ImportCEICoordinatorProtocol: class {
    func showAlert(_ alert: UIAlertController)
    func openCEIWebsite()
    func back()
}
