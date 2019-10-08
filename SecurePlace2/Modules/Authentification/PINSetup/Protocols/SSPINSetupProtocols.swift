//
//  SSPINSetupProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol PINSetupViewProtocol: class { }

protocol PINSetupWireFrameProtocol: class {
     func presentPINConfirmViewController(from view: MailViewProtocol?, type: PINConfirmModuleType, tokens: SignUpPositiveModel, pin: String)
}

protocol PINSetupPresenterProtocol: class {
    func getModuleType() -> PINSetupModuleType
}

protocol PINSetupInteractorProtocol: class { }
