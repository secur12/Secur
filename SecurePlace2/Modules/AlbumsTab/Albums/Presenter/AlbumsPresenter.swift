//
//  AlbumsPresenter.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//
import DKImagePickerController

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
    func didClickAddAlbumOnSheet() {
        view?.showAddAlbumAlert()
    }
    
    func didClickPhotoVideoOnSheet() {

    }
    
    func didClickCreateAlbum(named: String) {
        
    }
    
    func didClickPlusButton() {
        self.view?.showAddActionSheet()
    }
    
    func didSelectAlbum() {
        self.wireFrame.presentGallery(from: self.view)
    }
}
