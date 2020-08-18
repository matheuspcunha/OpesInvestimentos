//
//  UIStoryboard+Names.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var login: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    static var register: UIStoryboard {
        return UIStoryboard(name: "Register", bundle: nil)
    }
    
    static var wallet: UIStoryboard {
        return UIStoryboard(name: "Wallet", bundle: nil)
    }
}
