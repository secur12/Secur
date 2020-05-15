//
//  SSPrivateKeyProtocols.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol PrivateKeyViewProtocol: class {
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
}

protocol PrivateKeyWireFrameProtocol: class {
    func switchToTabBar(from view: PrivateKeyViewProtocol?)
}

protocol PrivateKeyPresenterProtocol: class {
    func didClickContinue(privateKey: String)
}

protocol PrivateKeyInteractorProtocol: class { }
