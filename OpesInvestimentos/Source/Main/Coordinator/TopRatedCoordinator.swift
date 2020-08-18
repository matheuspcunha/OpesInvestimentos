//
//  TopRatedCoordinator.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 13/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol TopRatedFlow: class {
    func coordinateToDetail()
}

class TopRatedCoordinator: CoordinatorProtocol, TopRatedFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let topRatedViewController = TopRatedViewController()
        topRatedViewController.coordinator = self
        
        navigationController?.pushViewController(topRatedViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail() {
//        let topRatedDetailCoordinator = TopRatedDetailCoordinator(navigationController: navigationController!)
//        coordinate(to: topRatedDetailCoordinator)
    }
}
