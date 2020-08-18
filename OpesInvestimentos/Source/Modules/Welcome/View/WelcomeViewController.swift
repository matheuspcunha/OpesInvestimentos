//
//  WelcomeViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {

    var coordinator: WelcomeFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = WelcomeView(delegate: self)
    }
}

extension WelcomeViewController: WelcomeViewDelegate {
    func loginButtonTapped() {
        coordinator?.coordinateToLogin()
    }
    
    func registerButtonTapped() {
        coordinator?.coordinateToRegister()
    }
}
