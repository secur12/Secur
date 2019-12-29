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
    func presentPINSetupViewController(type: PINModuleType, signUpModel: SignUpPositiveModel) -> UIViewController
    func presentPINSetupViewController(type: PINModuleType, oneTimeCodeModel: CheckOneTimeCodeModel) -> UIViewController
}

extension DIResolver: PINSetupProtocol {
    func presentPINSetupViewController(type: PINModuleType, signUpModel: SignUpPositiveModel) -> UIViewController {
        let viewController = PINSetupViewController()
        let interactor = PINSetupInteractor()
        let wireFrame = PINSetupWireFrame(resolver: self)
        let presenter = PINSetupPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, tokens: signUpModel)
        viewController.presenter = presenter
        return viewController
    }
    
    func presentPINSetupViewController(type: PINModuleType, oneTimeCodeModel: CheckOneTimeCodeModel) -> UIViewController {
        let viewController = PINSetupViewController()
        let interactor = PINSetupInteractor()
        let wireFrame = PINSetupWireFrame(resolver: self)
        let presenter = PINSetupPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, oneTimeCodeModel: oneTimeCodeModel)
        viewController.presenter = presenter
        return viewController
    }
}
