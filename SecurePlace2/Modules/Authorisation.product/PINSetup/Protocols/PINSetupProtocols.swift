//
//  SSPINSetupProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol PINSetupViewProtocol: class {
    func clearPin()
}

protocol PINSetupWireFrameProtocol: class {
    func presentPINConfirmSignUpViewController(from view: PINSetupViewProtocol?, accessToken: String, refreshToken: String, pin: String)
    func presentPINConfirmSignInNoKeyViewController(from view: PINSetupViewProtocol?, accessToken: String, refreshToken: String, pin: String)
    func presentPINConfirmSignInWithKeyViewController(from view: PINSetupViewProtocol?, accessToken: String, refreshToken: String, decryptKeySalt: String, decryptKeyIV: String, pin: String)
}

protocol PINSetupPresenterProtocol: class {
    func didFinishEnteringCode(code: String)
}

protocol PINSetupInteractorProtocol: class { }
