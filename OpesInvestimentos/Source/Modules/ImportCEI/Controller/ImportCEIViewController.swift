//
//  ImportCEIViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class ImportCEIViewController: UIViewController {

    // MARK: - Properties
    
    lazy var viewModel = ImportCEIViewModel()

    @IBOutlet weak var passwordField: CustomUITextField!
    @IBOutlet weak var cpfField: CustomUITextField!
    
     // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        TextFieldResponder.shared.add([passwordField, cpfField])
        
        viewModel.delegate = self
        self.cpfField.placeholder = viewModel.cpf
    }
    
    @IBAction func importFromCEI(_ sender: Any) {
        viewModel.importFromCEI(password: passwordField.text!)
    }
    
    @IBAction func goBack(_ sender: Any) {
        FirebaseService.signOut()
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ImportCEIViewController: ImportCEIViewModelDelegate {
    func onImport(result: Result<Bool, APIError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                print("Sucesso")
            case .failure(let error):
                print(error)
                Alert.show(title: "Algo deu errado 😔", message: "Por favor, tente novamente mais tarde", presenter: self)
            }
        }
    }
}
