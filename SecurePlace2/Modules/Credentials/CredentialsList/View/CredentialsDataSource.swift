//
//  CredentialsDataSource.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 17/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

protocol CredentialsDataSourceDelegate: class {
    func reloadData()
}

class CredentialsDataSource {

    private var credentials: [CredentialModel] = [CredentialModel(id: 1, serviceLogoImageTitle: "paypalLogo", serviceTitleLabel: "PayPal", usernameLabel: "bullstreak@gmail.com", password: "etyuuiij"), CredentialModel(id: 2, serviceLogoImageTitle: "googleLogo", serviceTitleLabel: "Google", usernameLabel: "test@gmail.com", password: "etyuuiij")]

    weak var delegate: CredentialsDataSourceDelegate?

    func getModelBy(index: Int) -> CredentialModel? {
        return credentials[index]
    }

    func getNumberOfSections() -> Int {
        return 1
    }

    func getNumberOfItems(in section: Int) -> Int {
        return self.credentials.count
    }

    func insertCredentials(_ items: [CredentialModel]) {
        self.updateCredentials(items)
    }

    func getCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CredentialCell", for: indexPath) as? CredentialCell else { return UITableViewCell() }
        cell.display(self.credentials[indexPath.row])
        return cell
    }

    private func updateCredentials(_ items: [CredentialModel]) {
        self.credentials = items
        self.delegate?.reloadData()
    }
}
