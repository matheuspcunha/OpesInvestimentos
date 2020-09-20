//
//  UIColor+AppColors.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UIColor {
    public class var appBlue: UIColor {
        return UIColor(red: 9/255, green: 78/255, blue: 246/255, alpha: 1.0)
    }
    
    public class var appGray: UIColor {
        return UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
    }
    
    public class var appBackground: UIColor {
        return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
    }
    
    public class var appTreasure: UIColor {
        return UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
    }
    
    public class var appFund: UIColor {
        return UIColor(red: 230/255.0, green: 126/255.0, blue: 34/255.0, alpha: 1.0)
    }
    
    public class var appStock: UIColor {
        return UIColor(red: 165/255.0, green: 94/255.0, blue: 234/255.0, alpha: 1.0)
    }
    
    public class var appPositive: UIColor {
        return UIColor(red: 68/255.0, green: 189/255.0, blue: 50/255.0, alpha: 1.0)
    }

    public class var appNegative: UIColor {
        return UIColor(red: 232/255.0, green: 65/255.0, blue: 24/255.0, alpha: 1.0)
    }
}
