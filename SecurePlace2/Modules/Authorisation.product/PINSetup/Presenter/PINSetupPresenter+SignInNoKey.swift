//
//  SSPINSetupPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class PINSetupSignInNoKeyPresenter: BasePresenter {

    weak var view: PINSetupViewProtocol?
    private var wireFrame: PINSetupWireFrameProtocol
    private var interactor: PINSetupInteractorProtocol

    private var accessToken: String
    private var refreshToken: String
    
    init(view: PINSetupViewProtocol, wireFrame: PINSetupWireFrameProtocol, interactor: PINSetupInteractorProtocol, accessToken: String, refreshToken: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

extension PINSetupSignInNoKeyPresenter: PINSetupPresenterProtocol {
    
    func didFinishEnteringCode(code: String) {
        self.wireFrame.presentPINConfirmSignInNoKeyViewController(from: self.view, accessToken: self.accessToken, refreshToken: self.refreshToken, pin: code)
    }
}
