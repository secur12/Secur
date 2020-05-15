//
//  SSMasterPasswordViewController.swift
//  SecurePlace2
//
//  Created by YY on 29/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//
 
import UIKit
import SnapKit

class MasterPasswordViewController: BaseViewController {

    var presenter: MasterPasswordPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension MasterPasswordViewController: MasterPasswordViewProtocol { }
