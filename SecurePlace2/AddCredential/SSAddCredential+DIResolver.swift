//
//  DIResolver+AddCredential.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - AddCredential
protocol AddCredentialProtocol {
    func presentAddCredentialViewController() -> UIViewController
}

extension DIResolver: AddCredentialProtocol {
    func presentAddCredentialViewController() -> UIViewController {
        let viewController = AddCredentialViewController()
        let interactor = AddCredentialInteractor()
        let wireFrame = AddCredentialWireFrame(resolver: self)
        let presenter = AddCredentialPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
