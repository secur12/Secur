//
//  SSCredentialsPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class CredentialsPresenter: BasePresenter {

    weak var view: CredentialsViewProtocol?
    private var wireFrame: CredentialsWireFrameProtocol
    private var interactor: CredentialsInteractorProtocol
    private var provider = CredentialLocalProvider(realmWrapper: RealmWrapper())

    init(view: CredentialsViewProtocol, wireFrame: CredentialsWireFrameProtocol, interactor: CredentialsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension CredentialsPresenter: CredentialsPresenterProtocol {

    func showCredentialDetailsWith(model: CredentialModel) {
        self.wireFrame.presentCredentialsDetails(from: self.view, model: model)
    }

    
    func deleteCredential(model: CredentialModel) {
        provider.deleteCredential(model) { (credentials) in
            if let credentials = credentials {
                self.view?.insertCredentials(models: credentials)
            }
        }
    }

    func didClickAddCredentialsButton() {
        self.wireFrame.presentAddCredentialController(from: self.view)
    }

    func reloadData() {
        provider.getCredentials() { (models, error) in
            self.view?.insertCredentials(models: models ?? [])
        }
    }

}
