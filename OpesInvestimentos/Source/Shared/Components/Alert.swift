//
//  Alert.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 02/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class Alert {
    
    static func show(title: String?, message: String?, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        presenter.present(alert, animated: true, completion: nil)
    }
    
    static func show(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        return alert
    }
}
