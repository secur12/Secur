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
    func presentPINSetupViewController(type: PINSetupModuleType, tokens: SignUpPositiveModel) -> UIViewController
}

extension DIResolver: PINSetupProtocol {
    func presentPINSetupViewController(type: PINSetupModuleType, tokens: SignUpPositiveModel) -> UIViewController {
        let viewController = PINSetupViewController()
        let interactor = PINSetupInteractor()
        let wireFrame = PINSetupWireFrame(resolver: self)
        let presenter = PINSetupPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, tokens: tokens)
        viewController.presenter = presenter
        return viewController
    }
}
