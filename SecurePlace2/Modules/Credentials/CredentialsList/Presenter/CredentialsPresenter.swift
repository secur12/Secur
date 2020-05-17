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

    init(view: CredentialsViewProtocol, wireFrame: CredentialsWireFrameProtocol, interactor: CredentialsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension CredentialsPresenter: CredentialsPresenterProtocol {
    
    func deleteCredential(model: CredentialModel) {

    }

    func didClickAddCredentialsButton() {

    }

}
