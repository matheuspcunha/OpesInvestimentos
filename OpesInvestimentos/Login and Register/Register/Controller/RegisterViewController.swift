//
//  RegisterViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    
    lazy var viewModel = RegisterViewModel()

    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var cpfField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var confirmPasswordField: CustomTextField!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        viewModel.register(name: nameField.text!, cpf: cpfField.text!,
                           email: emailField.text!, password: passwordField.text!,
                           confirmpassword: confirmPasswordField.text!)
    }
    
    private func showLoginScreen() {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        present(vc, animated: true)
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func onRegisterUser(result: Result<Bool, FirebaseError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.showLoginScreen()
            case .failure(let error):
                Alert.show(title: error.title, message: error.message, presenter: self)
            }
        }
    }
}
