//
//  SettingsViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 27/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

    private var viewModel: SettingsViewModelProtocol!
    private var contentView: SettingsView!

    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        self.contentView = SettingsView(viewModel: viewModel)
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ajustes"
    }
}
