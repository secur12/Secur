//
//  DIResolver+Gallery.swift
//  SecurePlace2
//
//  Created by YY on 02/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

// MARK: - Gallery
protocol GalleryProtocol {
    func presentGalleryViewController(album: AlbumModel) -> UIViewController
}

extension DIResolver: GalleryProtocol {
    func presentGalleryViewController(album: AlbumModel) -> UIViewController {
        //let datasource = GalleryDataSource()
        //let viewController = FMPhotoPickerViewController(config: FMPhotoPickerConfig())
//        let interactor = GalleryInteractor()
//        let wireFrame = GalleryWireFrame(resolver: self)
//        let presenter = GalleryPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
//        viewController.presenter = presenter
        var fv = FMPhotoPickerConfig()
        fv.mediaTypes = [.image, .video]
        return FMPhotoPickerViewController(config: fv, albumModel: album)
    }
}
