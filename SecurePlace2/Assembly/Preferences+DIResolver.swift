//
//  DIResolver+Preferences.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - Preferences
protocol PreferencesProtocol {
    func presentPreferencesViewController() -> UIViewController
}

extension DIResolver: PreferencesProtocol {
    func presentPreferencesViewController() -> UIViewController {
        let viewController = PreferencesViewController()
        let interactor = PreferencesInteractor()
        let wireFrame = PreferencesWireFrame(resolver: self)
        let presenter = PreferencesPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
