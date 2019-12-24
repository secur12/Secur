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
    func presentPINConfirmViewController(type: PINModuleType, tokens: SignUpPositiveModel, pin: String) -> UIViewController
}

extension DIResolver: PINConfirmProtocol {
    func presentPINConfirmViewController(type: PINModuleType, tokens: SignUpPositiveModel, pin: String) -> UIViewController {
        let viewController = PINConfirmViewController()
        let interactor = PINConfirmInteractor()
        let wireFrame = PINConfirmWireFrame(resolver: self)
        let presenter = PINConfirmPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, tokens: tokens, pin: pin)
        viewController.presenter = presenter
        return viewController
    }
}
