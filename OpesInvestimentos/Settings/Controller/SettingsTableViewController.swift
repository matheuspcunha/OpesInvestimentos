//
//  SettingsTableViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 27/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "endCell", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "syncCell", for: indexPath)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            logout()
        } else {
            sync()
        }
    }
    
    private func logout() {
        FirebaseService.signOut()
        let vc = UIStoryboard(name: "Welcome", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController")
        self.present(vc, animated: true)
    }
    
    private func sync() {
        let vc = UIStoryboard(name: "ImportCEI", bundle: nil).instantiateViewController(withIdentifier: "ImportCEIViewController")
        self.present(vc, animated: true)
    }
}
