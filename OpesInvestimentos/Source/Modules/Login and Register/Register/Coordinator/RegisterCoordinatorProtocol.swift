//
//  RegisterCoordinatorProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol RegisterCoordinatorProtocol: class {
    func coordinateToImportCEI()
    func showAlert(_ alert: UIAlertController)
    func back()
}
