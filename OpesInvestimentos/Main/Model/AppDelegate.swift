//
//  AppDelegate.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 30/05/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let vc: UIViewController
        
        if Auth.auth().currentUser != nil {
            if Defaults.shared.appStatus == AppStatus.ready.rawValue {
                vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
            } else {
                vc = UIStoryboard(name: "ImportCEI", bundle: nil).instantiateViewController(withIdentifier: "ImportCEIViewController")
            }
        } else {
            Firestore.firestore().clearPersistence { (error) in
                if let error = error {
                    print("Error Clear Persistence: \(error)")
                }
            }
            vc = UIStoryboard(name: "Welcome", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController")
        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

