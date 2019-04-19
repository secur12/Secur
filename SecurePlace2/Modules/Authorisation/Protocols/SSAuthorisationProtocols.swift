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
    func presentEmail(from view: AuthorisationViewProtocol?, type: EmailConttrollerType)
}

protocol AuthorisationPresenterProtocol: class {
    func switchToEmail(type: EmailConttrollerType)
}

protocol AuthorisationInteractorProtocol: class { }
