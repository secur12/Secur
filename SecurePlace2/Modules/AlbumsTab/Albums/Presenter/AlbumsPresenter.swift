//
//  AlbumsPresenter.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//
import Foundation

class AlbumsPresenter: BasePresenter {

    weak var view: AlbumsViewProtocol?
    private var wireFrame: AlbumsWireFrameProtocol
    private var interactor: AlbumsInteractorProtocol

    init(view: AlbumsViewProtocol, wireFrame: AlbumsWireFrameProtocol, interactor: AlbumsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension AlbumsPresenter: AlbumsPresenterProtocol {
    func didClickDeleteAlbum(album: AlbumModel) {
        self.interactor.deleteAlbum(album) { (albums) in
            if let albums = albums {
                self.view?.insertAlbums(albums: albums)
            }
        }
    }

    func viewDidLoad() {
        self.interactor.getAlbums { (albums, error) in
            if let error = error {
                self.view?.showOkAlertController(title: "Error", message: "Error with loading items", callback: nil)
                return
            }

            if let albums = albums {
                self.view?.insertAlbums(albums: albums)
            }

        }
    }
    
    func didClickCreateAlbum(named: String) {
        let album = AlbumModel(id: 0, albumTitle: named, numberOfItems: "", backgroundImage: nil, isLocked: false, password: nil)
        self.interactor.saveAlbum(album) { (newAlbum) in
            self.viewDidLoad()
        }
    }
    
    func didClickPlusButton() {
        view?.showAddAlbumAlert()
    }
    
    func didSelectAlbum(model: AlbumModel) {
        self.wireFrame.presentGallery(from: self.view, model: model)
    }
}
