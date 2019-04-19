//
//  SSAuthorisationPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class AuthorisationPresenter: BasePresenter {

    weak var view: AuthorisationViewProtocol?
    private var wireFrame: AuthorisationWireFrameProtocol
    private var interactor: AuthorisationInteractorProtocol

    init(view: AuthorisationViewProtocol, wireFrame: AuthorisationWireFrameProtocol, interactor: AuthorisationInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension AuthorisationPresenter: AuthorisationPresenterProtocol {
    func switchToEmail(type: EmailConttrollerType) {
        self.wireFrame.presentEmail(from: self.view, type: type)
    }
}
