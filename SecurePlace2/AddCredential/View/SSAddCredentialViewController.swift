//
//  SSAddCredentialViewController.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class AddCredentialViewController: BaseViewController {

    var presenter: AddCredentialPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension AddCredentialViewController: AddCredentialViewProtocol { }
