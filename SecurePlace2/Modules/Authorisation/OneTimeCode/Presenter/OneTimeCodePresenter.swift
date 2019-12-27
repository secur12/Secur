//
//  SSOneTimeCodePresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import Foundation

@objc enum OneTimeCodeModuleType: Int {
    case signIn
    case PINReset
    case coldpassInstall
}

class OneTimeCodePresenter: BasePresenter {

    weak var view: OneTimeCodeViewProtocol?
    private var wireFrame: OneTimeCodeWireFrameProtocol
    private var interactor: OneTimeCodeInteractorProtocol
    private var type: OneTimeCodeModuleType
    private var email: String
    
    init(view: OneTimeCodeViewProtocol, wireFrame: OneTimeCodeWireFrameProtocol, interactor: OneTimeCodeInteractorProtocol, type: OneTimeCodeModuleType, email: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.email = email
    }
}

extension OneTimeCodePresenter: OneTimeCodePresenterProtocol {
    
    func setDescriptionText() {
        self.view?.setDescriptionTextWithEmail(descriptionText: "We’ve sent one-time code to \n"+self.email, email: self.email, numberOfLines: 2)
    }
    
    func didClickContinue(code: String) {
        switch type {
            case .signIn:
                return
            
            case.PINReset:
                return
            
            case.coldpassInstall:
                return
        }
    }
    
    func checkSignInCode(code: String) {
        
    }
    
    func checkPINResetCode(code: String) {
        
    }
    
    func checkColdpassInstallCode(code: String) {
        
    }
}
