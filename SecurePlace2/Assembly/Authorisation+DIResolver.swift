//
//  DIResolver+Authorisation.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - Authorisation
protocol AuthorisationProtocol {
    func presentAuthorisationViewController() -> UIViewController
}

extension DIResolver: AuthorisationProtocol {
    func presentAuthorisationViewController() -> UIViewController {
        let viewController = AuthorisationViewController()
        let interactor = AuthorisationInteractor(networkController: self.networkController)
        let wireFrame = AuthorisationWireFrame(resolver: self)
        let presenter = AuthorisationPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
