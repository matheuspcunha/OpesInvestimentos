//
//  UIViewController+Instantiate.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> Self {
        let name = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
}
