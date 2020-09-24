//
//  WelcomeViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {

    private var viewModel: WelcomeViewModelProtocol!
    private var contentView: WelcomeView!

    init(viewModel: WelcomeViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = WelcomeView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
