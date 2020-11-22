//
//  InvestimentPriceViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentPriceViewController: UIViewController {

    private var viewModel: InvestimentPriceViewModelProtocol!
    private var contentView: InvestimentPriceView!
    
    init(viewModel: InvestimentPriceViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = InvestimentPriceView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadDetail()
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
        navigationItem.title = viewModel.viewData?.asset.symbol
    }
}
