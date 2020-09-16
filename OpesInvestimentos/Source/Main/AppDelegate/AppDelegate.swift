//
//  AppDelegate.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 30/05/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        window = UIWindow()
        
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
        
        return true
    }
}
