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

    private var type: PINSetupModuleType
    private var tokens: SignUpPositiveModel
    
    init(view: PINSetupViewProtocol, wireFrame: PINSetupWireFrameProtocol, interactor: PINSetupInteractorProtocol, type: PINSetupModuleType, tokens: SignUpPositiveModel) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.tokens = tokens
    }
    
    
    
}

extension PINSetupPresenter: PINSetupPresenterProtocol { }
