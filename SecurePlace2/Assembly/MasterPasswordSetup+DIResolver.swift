//
//  DIResolver+MasterPasswordSetup.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

enum MasterPasswordScreenType {
    case setupMasterPass
    case launchInput
    case changeTypeNewMasterPassword
    case changeTypeOldMasterPassword
}

// MARK: - MasterPasswordSetup
protocol MasterPasswordSetupProtocol {
    func presentMasterPasswordViewController(type: MasterPasswordScreenType, oldMasterPassword: String?) -> UIViewController
}

extension DIResolver: MasterPasswordSetupProtocol {
    func presentMasterPasswordViewController(type: MasterPasswordScreenType, oldMasterPassword: String?) -> UIViewController {
        let viewController = MasterPasswordSetupViewController()
        let interactor = MasterPasswordSetupInteractor()
        let wireFrame = MasterPasswordSetupWireFrame(resolver: self)
        let presenter = MasterPasswordSetupPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, oldMasterPassword: oldMasterPassword ?? "")
        viewController.presenter = presenter
        return viewController
    }
}
