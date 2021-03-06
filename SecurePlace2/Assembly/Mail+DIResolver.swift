//
//  DIResolver+test.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit

// MARK: - test
protocol MailProtocol {
    func presentMailViewController(type: EmailModuleType) -> UIViewController
}

extension DIResolver: MailProtocol {
    func presentMailViewController(type: EmailModuleType) -> UIViewController {
        let viewController = MailViewController()
        viewController.alignment = .center
        let interactor = MailInteractor(networkController: self.networkController)
        let wireFrame = MailWireFrame(resolver: self)
        let presenter = MailPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type)
        viewController.presenter = presenter
        return viewController
    }
}
