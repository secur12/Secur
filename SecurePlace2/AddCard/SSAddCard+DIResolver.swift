//
//  DIResolver+AddCard.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - AddCard
protocol AddCardProtocol {
    func presentAddCardViewController() -> UIViewController
}

extension DIResolver: AddCardProtocol {
    func presentAddCardViewController() -> UIViewController {
        let viewController = AddCardViewController()
        let interactor = AddCardInteractor()
        let wireFrame = AddCardWireFrame(resolver: self)
        let presenter = AddCardPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
