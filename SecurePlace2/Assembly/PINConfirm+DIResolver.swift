//
//  DIResolver+PINConfirm.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - PINConfirm
protocol PINConfirmProtocol {
    func presentPINConfirmSignUpViewController(accessToken: String, refreshToken: String, pin: String) -> UIViewController
    func presentPINConfirmSignInNoKeyViewController(accessToken: String, refreshToken: String, pin: String) -> UIViewController
    func presentPINConfirmSignInWithKeyViewController(accessToken: String, refreshToken: String, decryptKeySalt: String, decryptKeyIV: String, pin: String) -> UIViewController
}

extension DIResolver: PINConfirmProtocol {
    func presentPINConfirmSignUpViewController(accessToken: String, refreshToken: String, pin: String) -> UIViewController {
        let viewController = PINConfirmViewController()
        let interactor = PINConfirmInteractor()
        let wireFrame = PINConfirmWireFrame(resolver: self)
        let presenter = PINConfirmSignUpPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, accessToken: accessToken, refreshToken: refreshToken, pin: pin)
        viewController.presenter = presenter
        return viewController
    }
    
    func presentPINConfirmSignInNoKeyViewController(accessToken: String, refreshToken: String, pin: String) -> UIViewController {
        let viewController = PINConfirmViewController()
        let interactor = PINConfirmInteractor()
        let wireFrame = PINConfirmWireFrame(resolver: self)
        let presenter = PINConfirmSignInNoKeyPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, accessToken: accessToken, refreshToken: refreshToken, pin: pin)
        viewController.presenter = presenter
        return viewController
    }
    
    func presentPINConfirmSignInWithKeyViewController(accessToken: String, refreshToken: String, decryptKeySalt: String, decryptKeyIV: String, pin: String) -> UIViewController {
        let viewController = PINConfirmViewController()
        let interactor = PINConfirmInteractor()
        let wireFrame = PINConfirmWireFrame(resolver: self)
        let presenter = PINConfirmSignInWithKeyPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, accessToken: accessToken, refreshToken: refreshToken, decryptKeySalt: decryptKeySalt, decryptKeyIV: decryptKeyIV, pin: pin)
        viewController.presenter = presenter
        return viewController
    }
}
