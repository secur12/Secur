//
//  SSPINSetupPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class PINSetupPresenter: BasePresenter {

    weak var view: PINSetupViewProtocol?
    private var wireFrame: PINSetupWireFrameProtocol
    private var interactor: PINSetupInteractorProtocol

    private var type: PINModuleType
    private var accessToken: String
    private var refreshToken: String
    
    init(view: PINSetupViewProtocol, wireFrame: PINSetupWireFrameProtocol, interactor: PINSetupInteractorProtocol, type: PINModuleType, tokens: SignUpPositiveModel) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.accessToken = tokens.access_token
        self.refreshToken = tokens.refresh_token
    }
    
    init(view: PINSetupViewProtocol, wireFrame: PINSetupWireFrameProtocol, interactor: PINSetupInteractorProtocol, type: PINModuleType, oneTimeCodeModel: CheckOneTimeCodeModel) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.accessToken = oneTimeCodeModel.access_token
        self.refreshToken = oneTimeCodeModel.refresh_token
    }
}

extension PINSetupPresenter: PINSetupPresenterProtocol {
    
    func didFinishEnteringCode(code: String) {
        self.wireFrame.presentPINConfirmViewController(from: self.view, type: self.type, accessToken: self.accessToken, refreshToken: self.refreshToken, pin: code)
    }
}
