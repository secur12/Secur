//
//  SSOneTimeCodeViewController.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class OneTimeCodeViewController: BaseViewController {

    var presenter: OneTimeCodePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension OneTimeCodeViewController: OneTimeCodeViewProtocol { }
