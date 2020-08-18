//
//  LooginViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    private var viewModel: LoginViewModel!
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        view = LoginView(viewModel: viewModel)
    }
}
