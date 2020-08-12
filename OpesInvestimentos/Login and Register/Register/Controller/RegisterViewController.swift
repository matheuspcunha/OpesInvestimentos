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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameField: CustomUITextField!
    @IBOutlet weak var cpfField: CustomUITextField!
    @IBOutlet weak var emailField: CustomUITextField!
    @IBOutlet weak var passwordField: CustomUITextField!
    @IBOutlet weak var confirmPasswordField: CustomUITextField!
    
    private lazy var viewModel = RegisterViewModel()
        
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        TextFieldResponder.shared.add([nameField, cpfField, emailField, passwordField, confirmPasswordField])

        viewModel.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        viewModel.register(name: nameField.text!, cpf: cpfField.text!,
                           email: emailField.text!, password: passwordField.text!,
                           confirmpassword: confirmPasswordField.text!)
    }
    
    private func showImportCEIScreen() {
        weak var pvc = self.presentingViewController

        self.dismiss(animated: false) {
            let vc = UIStoryboard(name: "ImportCEI", bundle: nil).instantiateViewController(withIdentifier: "ImportCEIViewController")
            pvc?.present(vc, animated: true)
        }
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = keyboardValue.cgRectValue
        let keyboardViewFrame = view.convert(keyboardFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    
    func onRegisterUser(result: Result<Bool, FirebaseError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.showImportCEIScreen()
            case .failure(let error):
                Alert.show(title: error.title, message: error.message, presenter: self)
            }
        }
    }
}
