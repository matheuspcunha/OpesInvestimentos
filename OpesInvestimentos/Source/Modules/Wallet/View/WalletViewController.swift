//
//  WalletViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WalletViewController: UIViewController {

    private var viewModel: WalletViewModelProtocol!
    private var contentView: WalletView!
    
    init(viewModel: WalletViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = WalletView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadWallet()
        let teste = CEIServiceAPI()
        teste.requestTest()
    }

    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Carteira"
    }
}
