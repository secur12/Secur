//
//  SSPreferencesPresenter.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class PreferencesPresenter: BasePresenter {

    weak var view: PreferencesViewProtocol?
    private var wireFrame: PreferencesWireFrameProtocol
    private var interactor: PreferencesInteractorProtocol

    init(view: PreferencesViewProtocol, wireFrame: PreferencesWireFrameProtocol, interactor: PreferencesInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension PreferencesPresenter: PreferencesPresenterProtocol {

    func showMasterPasswordChange() {
        self.wireFrame.presentChangeMasterPassword(from: self.view)
    }
}
