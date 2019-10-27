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
        let viewController = StartScreenViewController()
        let interactor = StartScreenInteractor(networkController: self.networkController)
        let wireFrame = StartScreenWireFrame(resolver: self)
        let presenter = StartScreenPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
