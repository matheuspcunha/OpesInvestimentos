//
//  WalletCollectionViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class WalletCollectionViewController: UICollectionViewController {

    // MARK: - Properties

    @IBOutlet weak var emptyWalletStack: UIStackView!
    
    private lazy var viewModel = WalletViewModel()
    
    private let indicator = UIActivityIndicatorView(style: .medium)
    
    private lazy var layoutSections: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (index, environment) -> NSCollectionLayoutSection? in
            return self.viewModel.getSection(in: index).layoutSection()
        }
        
        return layout
     }()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        configureIndicator()
        configureRefreshControl()
        
        self.collectionView.register(UINib(nibName: String(describing: TotalViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TotalViewCell.self))
        self.collectionView.register(UINib(nibName: String(describing: NameViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: NameViewCell.self))
        self.collectionView.register(UINib(nibName: String(describing: TypeViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TypeViewCell.self))

        viewModel.walletLoaded = walletLoaded
    }

    override func viewWillAppear(_ animated: Bool) {
        indicator.startAnimating()
        loadWallet()
    }
    
    @objc private func loadWallet() {
        viewModel.loadWallet()
    }
    
    private func walletLoaded() {
        DispatchQueue.main.async {
            if self.viewModel.count == 0 {
                self.setEmpty()
            } else {
                self.collectionView.collectionViewLayout = self.layoutSections
                self.collectionView.reloadData()
            }
            
            self.indicator.stopAnimating()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureIndicator() {
        indicator.center = collectionView.center
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(loadWallet), for: .valueChanged)
    }
    
    private func setEmpty() {
        self.emptyWalletStack.isHidden = false
        self.collectionView.isScrollEnabled = false
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getSection(in: indexPath.section).configure(collectionView: collectionView, indexPath: indexPath)
    }
    
}
