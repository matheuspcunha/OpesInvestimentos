//
//  ScreenLoader.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 12/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol ScreenLoader {
    func showLoading(_ show: Bool)
}

extension ScreenLoader {
    func showLoading(_ show: Bool) {
        DispatchQueue.main.async {
            if show {
                let loadingText =  "Carregando..."
                LoadingView.spin(loadingText: loadingText)
            } else {
                LoadingView.stop()
            }
        }
    }
}
