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
        if(code.isInt && code.count==6) {
            switch type {
               case .signIn:
                   checkOneTimeSignIn(code: code)
               
               case.PINReset:
                   checkOneTimePINReset(code: code)
               
               case.coldpassInstall:
                   checkOneTimeColdpassInstall(code: code)
           }
    
        } else {
            self.view?.clearCodeTextField()
            self.view?.showOkAlertController(title: "Wrong format!", message: "Please enter a valid one-time code", callback: nil)
        }
    }
    
    func checkOneTimeSignIn(code: String) {
        self.view?.showLoading(message: "Loading...")
        self.interactor.checkOneTimeSignIn(with: code) { (model, error) in
           defer { self.view?.hideLoading() }
            
           if let error = error {
                print(error.localizedDescription)
                if(error.errorCode == 401) {
                self.view?.showOkAlertController(title: "Wrong one-time code", message: "One-time code that you entered doesn't match with the code we've sent to your email", callback: nil)
            } else {
                self.view?.showOkAlertController(title: "Error", message: "Something went wrong, error \(String(describing: error.errorCode))", callback: nil)
            }
            return
        }
            
            if let model = model {
                if (model.userInstalledColdPass) {
                    self.wireFrame.presentMasterPassword(from: self.view, type: .signIn, accessToken: model.access_token, refreshToken: model.refresh_token, decryptKeySalt: model.decryptKeySalt, decryptKeyIV: model.decryptKeyIV)
                } else {
                    self.wireFrame.presentPINSetupNoKey(from: self.view, accessToken: model.access_token, refreshToken: model.refresh_token)
                }
        }
    }
}
    
    func checkOneTimePINReset(code: String) {
        
    }
    
    func checkOneTimeColdpassInstall(code: String) {
        
    }
}
