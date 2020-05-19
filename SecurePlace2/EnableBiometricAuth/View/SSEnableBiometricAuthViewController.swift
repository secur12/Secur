//
//  SSEnableBiometricAuthViewController.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class EnableBiometricAuthViewController: BaseViewController {

    var presenter: EnableBiometricAuthPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension EnableBiometricAuthViewController: EnableBiometricAuthViewProtocol { }
