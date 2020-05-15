//
//  DIResolver+PrivateKey.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - PrivateKey
protocol PrivateKeyProtocol {
    func presentPrivateKeyViewController(password: String) -> UIViewController
}

extension DIResolver: PrivateKeyProtocol {
    func presentPrivateKeyViewController(password: String) -> UIViewController {
        let viewController = PrivateKeyViewController()
        let interactor = PrivateKeyInteractor()
        let wireFrame = PrivateKeyWireFrame(resolver: self)
        let presenter = PrivateKeyPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, password: password)
        viewController.presenter = presenter
        return viewController
    }
}
