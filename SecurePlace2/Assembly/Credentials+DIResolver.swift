//
//  DIResolver+Credentials.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - Credentials
protocol CredentialsProtocol {
    func presentCredentialsViewController() -> UIViewController
}

extension DIResolver: CredentialsProtocol {
    func presentCredentialsViewController() -> UIViewController {
        let viewController = CredentialsViewController()
        let interactor = CredentialsInteractor()
        let wireFrame = CredentialsWireFrame(resolver: self)
        let presenter = CredentialsPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
