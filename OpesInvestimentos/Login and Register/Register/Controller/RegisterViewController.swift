//
//  RegisterViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    let collection = "UserInfo"
    
    let firestore: Firestore = {
        let firestore = Firestore.firestore()
        return firestore
    }()
    
    var firestoreListener: ListenerRegistration!
    
    lazy var viewModel = RegisterViewModel()

    @IBOutlet weak var nameField: CustomTextField!
    @IBOutlet weak var cpfField: CustomTextField!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var confirmPasswordField: CustomTextField!
    
    lazy var auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        viewModel.register(name: emailField.text!, cpf: cpfField.text!,
                           email: emailField.text!, password: confirmPasswordField.text!)
    }    
}
