//
//  SSCredentialsViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class CredentialsViewController: BaseViewController {

    var presenter: CredentialsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension CredentialsViewController: CredentialsViewProtocol { }
