//
//  SSCredentialServicesPresenter.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

class CredentialServicesPresenter: BasePresenter {

    weak var view: CredentialServicesViewProtocol?
    private var wireFrame: CredentialServicesWireFrameProtocol
    private var interactor: CredentialServicesInteractorProtocol

    init(view: CredentialServicesViewProtocol, wireFrame: CredentialServicesWireFrameProtocol, interactor: CredentialServicesInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension CredentialServicesPresenter: CredentialServicesPresenterProtocol { }
