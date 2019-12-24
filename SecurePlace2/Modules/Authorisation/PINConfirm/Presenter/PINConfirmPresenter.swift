//
//  SSPINConfirmPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class PINConfirmPresenter: BasePresenter {

    weak var view: PINConfirmViewProtocol?
    private var wireFrame: PINConfirmWireFrameProtocol
    private var interactor: PINConfirmInteractorProtocol

    private var type: PINModuleType
    private var tokens: SignUpPositiveModel
    private var pin: String
    
    init(view: PINConfirmViewProtocol, wireFrame: PINConfirmWireFrameProtocol, interactor: PINConfirmInteractorProtocol, type: PINModuleType, tokens: SignUpPositiveModel, pin: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.tokens = tokens
        self.pin = pin
    }
    
    func getModuleType() -> PINModuleType {
        return self.type
    }
    
}

extension PINConfirmPresenter: PINConfirmPresenterProtocol {
    
    func didFinishEnteringCode(code: String) {
        
    }
}
