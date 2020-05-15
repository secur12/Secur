//
//  SSCredentialServicesViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class CredentialServicesViewController: BaseViewController {

    var presenter: CredentialServicesPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension CredentialServicesViewController: CredentialServicesViewProtocol { }
