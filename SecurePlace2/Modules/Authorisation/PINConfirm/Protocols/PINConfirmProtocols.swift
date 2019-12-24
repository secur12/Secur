//
//  SSPINConfirmProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol PINConfirmViewProtocol: class {
    func showLoading(message: String?)
    func hideLoading()
    func showAlert(title: String?, message: String?, buttons: [UIAlertAction])
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func clearPin()
}

protocol PINConfirmWireFrameProtocol: class { }

protocol PINConfirmPresenterProtocol: class {
    func didFinishEnteringCode(code: String)
}

protocol PINConfirmInteractorProtocol: class {
}
