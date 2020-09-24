//
//  LoginCoordinatorProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol LoginCoordinatorProtocol: class {
    func coordinateToTabBar()
    func coordinateToForgotPassword()
    func coordinateToImportCEI()
    func showAlert(_ alert: UIAlertController)
    func back()
}
