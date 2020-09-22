//
//  SettingsViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 11/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class SettingsViewModel: SettingsViewModelProtocol {

    var view: SettingsViewProtocol?
    private var coordinator: SettingsCoordinatorProtocol?

    init(coordinator: SettingsCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func showSetting(for type: Settings) {
        switch type {
        case .account:
            print("account")
        case .exit:
            FirebaseService.signOut()
        }
    }
}
