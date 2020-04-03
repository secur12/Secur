//
//  SSGalleryPresenter.swift
//  SecurePlace2
//
//  Created by YY on 02/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class GalleryPresenter: BasePresenter {

    weak var view: GalleryViewProtocol?
    private var wireFrame: GalleryWireFrameProtocol
    private var interactor: GalleryInteractorProtocol

    init(view: GalleryViewProtocol, wireFrame: GalleryWireFrameProtocol, interactor: GalleryInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension GalleryPresenter: GalleryPresenterProtocol { }
