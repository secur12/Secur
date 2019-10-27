//
//  SSPINConfirmProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol PINConfirmViewProtocol: class { }

protocol PINConfirmWireFrameProtocol: class { }

protocol PINConfirmPresenterProtocol: class {
    func getModuleType() -> PINConfirmModuleType
}

protocol PINConfirmInteractorProtocol: class { }
