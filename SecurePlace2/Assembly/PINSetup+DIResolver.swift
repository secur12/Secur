//
//  DIResolver+PINSetup.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - PINSetup
protocol PINSetupProtocol {
    func presentPINSetupSignUpViewController(accessToken: String, refreshToken: String) -> UIViewController
    func presentPINSetupSignInNoKeyViewController(accessToken: String, refreshToken: String) -> UIViewController
}

extension DIResolver: PINSetupProtocol {
    
    func presentPINSetupSignUpViewController(accessToken: String, refreshToken: String) -> UIViewController {
        let viewController = PINSetupViewController()
        let interactor = PINSetupInteractor()
        let wireFrame = PINSetupWireFrame(resolver: self)
        let presenter = PINSetupSignUpPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, accessToken: accessToken, refreshToken: refreshToken)
        viewController.presenter = presenter
        return viewController
    }
    
    func presentPINSetupSignInNoKeyViewController(accessToken: String, refreshToken: String) -> UIViewController {
        let viewController = PINSetupViewController()
        let interactor = PINSetupInteractor()
        let wireFrame = PINSetupWireFrame(resolver: self)
        let presenter = PINSetupSignInNoKeyPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, accessToken: accessToken, refreshToken: refreshToken)
        viewController.presenter = presenter
        return viewController
    }
}
