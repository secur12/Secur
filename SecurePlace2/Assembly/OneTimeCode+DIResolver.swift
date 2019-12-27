//
//  DIResolver+OneTimeCode.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - OneTimeCode
protocol OneTimeCodeProtocol {
    func presentOneTimeCodeViewController(type: OneTimeCodeModuleType, email: String) -> UIViewController
}

extension DIResolver: OneTimeCodeProtocol {
    func presentOneTimeCodeViewController(type: OneTimeCodeModuleType, email: String) -> UIViewController {
        let viewController = OneTimeCodeViewController()
        let interactor = OneTimeCodeInteractor(networkController: self.networkController)
        let wireFrame = OneTimeCodeWireFrame(resolver: self)
        let presenter = OneTimeCodePresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, email: email)
        viewController.presenter = presenter
        return viewController
    }
}
