//
//  DIResolver+Cards.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - Cards
protocol CardsProtocol {
    func presentCardsViewController() -> UIViewController
}

extension DIResolver: CardsProtocol {
    func presentCardsViewController() -> UIViewController {
        let viewController = CardsViewController()
        let interactor = CardsInteractor()
        let wireFrame = CardsWireFrame(resolver: self)
        let presenter = CardsPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
