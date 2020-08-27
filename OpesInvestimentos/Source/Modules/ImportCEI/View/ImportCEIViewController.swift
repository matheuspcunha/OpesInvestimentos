//
//  ImportCEIViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class ImportCEIViewController: UIViewController {

    private var viewModel: ImportCEIViewModelProtocol!
    private var contentView: ImportCEIView!

    init(viewModel: ImportCEIViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = ImportCEIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
    }
}
