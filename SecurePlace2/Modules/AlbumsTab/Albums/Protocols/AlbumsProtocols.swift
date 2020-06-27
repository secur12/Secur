//
//  AlbumsProtocols.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol AlbumsViewProtocol: class {
    func showAddAlbumAlert()
    func insertAlbums(albums: [AlbumModel])
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func showAlert(title: String?, message: String?, buttons: [UIAlertAction])
}

protocol AlbumsWireFrameProtocol: class {
    func presentGallery(from view: AlbumsViewProtocol?, model: AlbumModel)
}

protocol AlbumsPresenterProtocol: class {
    func viewDidLoad()
    func didClickDeleteAlbum(album: AlbumModel)
    func didSelectAlbum(model: AlbumModel)
    func didClickPlusButton()
    func didClickCreateAlbum(named: String)
}

protocol AlbumsInteractorProtocol: class {
    func saveAlbum(_ album: AlbumModel, completion: ((AlbumModel?) -> Void)?)
    func deleteAlbum(_ album: AlbumModel, completion: (([AlbumModel]?) -> Void)?)
    func getAlbums(_ completion: (([AlbumModel]?, Error?) -> Void)?)
}




