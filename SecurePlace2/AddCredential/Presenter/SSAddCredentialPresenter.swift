//
//  SSAddCredentialPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class AddCredentialPresenter: BasePresenter {

    weak var view: AddCredentialViewProtocol?
    private var wireFrame: AddCredentialWireFrameProtocol
    private var interactor: AddCredentialInteractorProtocol

    init(view: AddCredentialViewProtocol, wireFrame: AddCredentialWireFrameProtocol, interactor: AddCredentialInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension AddCredentialPresenter: AddCredentialPresenterProtocol { }
