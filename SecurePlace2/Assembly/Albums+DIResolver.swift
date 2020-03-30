//
//  DIResolver+Albums.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - Albums
protocol AlbumsProtocol {
    func presentAlbumsViewController() -> UIViewController
}

extension DIResolver: AlbumsProtocol {
    func presentAlbumsViewController() -> UIViewController {
        let viewController = AlbumsViewController()
        let interactor = AlbumsInteractor()
        let wireFrame = AlbumsWireFrame(resolver: self)
        let presenter = AlbumsPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
