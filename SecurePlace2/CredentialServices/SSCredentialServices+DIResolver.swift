//
//  DIResolver+CredentialServices.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - CredentialServices
protocol CredentialServicesProtocol {
    func presentCredentialServicesViewController() -> UIViewController
}

extension DIResolver: CredentialServicesProtocol {
    func presentCredentialServicesViewController() -> UIViewController {
        let viewController = CredentialServicesViewController()
        let interactor = CredentialServicesInteractor()
        let wireFrame = CredentialServicesWireFrame(resolver: self)
        let presenter = CredentialServicesPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
