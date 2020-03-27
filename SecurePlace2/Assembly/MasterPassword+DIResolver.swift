//
//  DIResolver+MasterPassword.swift
//  SecurePlace2
//
//  Created by YY on 29/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - MasterPassword
protocol MasterPasswordProtocol {
    func presentMasterPasswordViewController(type: MasterPasswordModuleType, accessToken: String?, refreshToken: String?, decryptKeySalt: String?, decryptKeyIV: String?) -> UIViewController
}

extension DIResolver: MasterPasswordProtocol {
    func presentMasterPasswordViewController(type: MasterPasswordModuleType, accessToken: String?, refreshToken: String?, decryptKeySalt: String?, decryptKeyIV: String?) -> UIViewController {
        let viewController = MasterPasswordViewController()
        let interactor = MasterPasswordInteractor()
        let wireFrame = MasterPasswordWireFrame(resolver: self)
        let presenter = MasterPasswordPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, accessToken: accessToken, refreshToken: refreshToken, decryptKeySalt: decryptKeySalt, decryptKeyIV: decryptKeyIV)
        viewController.presenter = presenter
        return viewController
    }
}
