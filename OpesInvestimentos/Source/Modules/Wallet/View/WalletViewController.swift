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
    
//    private lazy var viewModel = WalletViewModel()
//
//    weak var coordinator: WalletCoordinator?
//
//    private let indicator = UIActivityIndicatorView(style: .medium)
//
//    private lazy var layoutSections: UICollectionViewLayout = {
//        let layout = UICollectionViewCompositionalLayout { (index, environment) -> NSCollectionLayoutSection? in
//            return self.viewModel.getItem(at: index).layoutSection()
//        }
//
//        return layout
//     }()
//
//    fileprivate let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        cv.register(UINib(nibName: String(describing: TotalViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TotalViewCell.self))
//        cv.register(UINib(nibName: String(describing: NameViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: NameViewCell.self))
//        cv.register(UINib(nibName: String(describing: TypeViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TypeViewCell.self))
//        cv.register(UINib(nibName: String(describing: PieViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PieViewCell.self))
//        return cv
//    }()
//
//    // MARK: - Methods
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .white
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//
//        configureIndicator()
//        configureRefreshControl()
//
//        viewModel.walletLoaded = walletLoaded
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        indicator.startAnimating()
//        loadWallet()
//    }
//
//    @objc private func loadWallet() {
//        viewModel.loadWallet()
//    }
//
//    private func walletLoaded() {
//        DispatchQueue.main.async {
//            if self.viewModel.count > 0 {
//                self.collectionView.collectionViewLayout = self.layoutSections
//                self.collectionView.reloadData()
//            }
//
//            self.indicator.stopAnimating()
//            self.collectionView.refreshControl?.endRefreshing()
//        }
//    }
//
//    private func configureIndicator() {
//        indicator.center = collectionView.center
//        indicator.hidesWhenStopped = true
//        self.view.addSubview(indicator)
//    }
//
//    private func configureRefreshControl() {
//        collectionView.refreshControl = UIRefreshControl()
//        collectionView.refreshControl?.addTarget(self, action: #selector(loadWallet), for: .valueChanged)
//    }
}

//extension WalletViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        viewModel.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.numberOfItems(in: section)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let item = viewModel.getItem(at: indexPath.section)
//
//        switch item.type {
//        case .name:
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NameViewCell.self), for: indexPath) as? NameViewCell {
//                cell.configure(with: item as! WalletViewModelNameItem)
//                return cell
//            }
//        case .total:
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TotalViewCell.self), for: indexPath) as? TotalViewCell {
//                cell.configure(with: item as! WalletViewModelTotalItem)
//                return cell
//            }
//        case .type:
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TypeViewCell.self), for: indexPath) as? TypeViewCell {
//                cell.configure(with: item as! WalletViewModelTypeItem)
//                return cell
//            }
//        case .pie:
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PieViewCell.self), for: indexPath) as? PieViewCell {
//                cell.configure(with: item as! WalletViewModelPieItem)
//                return cell
//            }
//        }
//
//        return UICollectionViewCell()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("item at \(indexPath.section)/\(indexPath.item) tapped")
//    }
//}
