//
//  AlbumsProtocols.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol AlbumsViewProtocol: class {
    func showAddActionSheet()
    func showAddAlbumAlert()
}

protocol AlbumsWireFrameProtocol: class {
    func presentGallery(from view: AlbumsViewProtocol?)
}

protocol AlbumsPresenterProtocol: class {
    func didSelectAlbum()
    func didClickPlusButton()
    func didClickAddAlbumOnSheet()
    func didClickPhotoVideoOnSheet()
    func didClickCreateAlbum(named: String)
}

protocol AlbumsInteractorProtocol: class { }
