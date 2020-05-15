//
//  StartScreenProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol StartScreenViewProtocol: class { }

protocol StartScreenWireFrameProtocol: class {
    func presentMasterPassword(from view: StartScreenViewProtocol?)
    //func presentEmail(from view: StartScreenViewProtocol?, type: EmailModuleType)
}

protocol StartScreenPresenterProtocol: class {
    //func switchToEmail(type: EmailModuleType)
    func switchToMaster()
}

protocol StartScreenInteractorProtocol: class { }
