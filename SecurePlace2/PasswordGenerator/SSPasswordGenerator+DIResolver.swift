//
//  DIResolver+PasswordGenerator.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - PasswordGenerator
protocol PasswordGeneratorProtocol {
    func presentPasswordGeneratorViewController() -> UIViewController
}

extension DIResolver: PasswordGeneratorProtocol {
    func presentPasswordGeneratorViewController() -> UIViewController {
        let viewController = PasswordGeneratorViewController()
        let interactor = PasswordGeneratorInteractor()
        let wireFrame = PasswordGeneratorWireFrame(resolver: self)
        let presenter = PasswordGeneratorPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
