//
//  Alert.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 02/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class Alert {

    static func make(title: String?, message: String?, handler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
            guard let handler = handler else {return}
            handler()
        })
        alert.addAction(okAction)
        
        return alert
    }
}
