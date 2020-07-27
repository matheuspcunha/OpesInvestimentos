//
//  LoginViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 20/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailField: CustomUITextField!
    @IBOutlet weak var passwordField: CustomUITextField!
    
    lazy var viewModel = LoginViewModel()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func signIn(_ sender: Any) {
        viewModel.login(withEmail: emailField.text!, password: passwordField.text!)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func showMainScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController")
        present(vc, animated: true)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func onLoginUser(result: Result<Bool, FirebaseError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.showMainScreen()
            case .failure(let error):
                Alert.show(title: error.title, message: error.message, presenter: self)
            }
        }
    }
}
