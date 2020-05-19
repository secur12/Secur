//
//  DIResolver+EnableBiometricAuth.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - EnableBiometricAuth
protocol EnableBiometricAuthProtocol {
    func presentEnableBiometricAuthViewController() -> UIViewController
}

extension DIResolver: EnableBiometricAuthProtocol {
    func presentEnableBiometricAuthViewController() -> UIViewController {
        let viewController = EnableBiometricAuthViewController()
        let interactor = EnableBiometricAuthInteractor()
        let wireFrame = EnableBiometricAuthWireFrame(resolver: self)
        let presenter = EnableBiometricAuthPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
