//
//  InvestimentListViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentListViewController: UIViewController {

    private var viewModel: InvestimentListViewModelProtocol!
    private var contentView: InvestimentListView!
    
    init(viewModel: InvestimentListViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = InvestimentListView(viewModel: viewModel)
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
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .appBlue
        navigationItem.title = viewModel.attributes.name
    }
}
