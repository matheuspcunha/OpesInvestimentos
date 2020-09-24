//
//  ViewCodeProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 15/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

protocol ViewCodeProtocol {
    func setupHierarchy()
    func setupConstraints()
    func additionalSetup()

    func buildView()
}

extension ViewCodeProtocol {
    func buildView() {
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {}
    func setupConstraints() {}
}
