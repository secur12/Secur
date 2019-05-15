//
//  SSAuthorisationProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol AuthorisationViewProtocol: class { }

protocol AuthorisationWireFrameProtocol: class {
    func presentEmail(from view: AuthorisationViewProtocol?, type: EmailModuleType)
}

protocol AuthorisationPresenterProtocol: class {
    func switchToEmail(type: EmailModuleType)
}

protocol AuthorisationInteractorProtocol: class { }
