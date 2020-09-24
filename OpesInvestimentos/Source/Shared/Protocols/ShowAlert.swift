//
//  ShowAlert.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol ShowAlert {
    func showAlert(_ alert: UIAlertController)
}

extension ShowAlert where Self: CoordinatorProtocol {
    func showAlert(_ alert: UIAlertController) {
        self.navigationController.present(alert, animated: true, completion: nil)
    }
}
