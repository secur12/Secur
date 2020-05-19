//
//  SSMasterPasswordSetupProtocols.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol MasterPasswordSetupViewProtocol: class {
    func setupLaunchInputTexts()
    func setupSetupMasterTexts()
    func setupChangeTypeNewMasterPassword()
    func setupChangeTypeOldMasterPassword()
    func passwordNotComplex()
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
}

protocol MasterPasswordSetupWireFrameProtocol: class {
    func switchToPrivateKey(from view: MasterPasswordSetupViewProtocol?, password: String)
    func switchToTypeNewMasterPassword(from view: MasterPasswordSetupViewProtocol?, oldMasterPassword: String)
    func switchToTabBar(from view: MasterPasswordSetupViewProtocol?)
}

protocol MasterPasswordSetupPresenterProtocol: class {
    func didClickContinue(password: String)
    func viewDidLoad()
}

protocol MasterPasswordSetupInteractorProtocol: class { }
