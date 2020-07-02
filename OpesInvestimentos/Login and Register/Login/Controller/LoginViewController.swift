//
//  LoginViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 20/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(_ sender: Any) {
        FirebaseService.login(withEmail: emailField.text!, password: passwordField.text!) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success( _):
                self.showMainScreen()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func showMainScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController")
        present(vc, animated: true)
    }
}
