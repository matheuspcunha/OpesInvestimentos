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
            return self.viewModel.getItem(at: index).layoutSection()
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
        self.collectionView.register(UINib(nibName: String(describing: PieViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PieViewCell.self))

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
        let item = viewModel.getItem(at: indexPath.section)
        
        switch item.type {
        case .name:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NameViewCell.self), for: indexPath) as? NameViewCell {
                cell.configure(with: item as! WalletViewModelNameItem)
                return cell
            }
        case .total:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TotalViewCell.self), for: indexPath) as? TotalViewCell {
                cell.configure(with: item as! WalletViewModelTotalItem)
                return cell
            }
        case .type:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TypeViewCell.self), for: indexPath) as? TypeViewCell {
                cell.configure(with: item as! WalletViewModelTypeItem)
                return cell
            }
        case .pie:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PieViewCell.self), for: indexPath) as? PieViewCell {
                cell.configure(with: item as! WalletViewModelPieItem)
                return cell
            }
        }

        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
    }
}
