//
//  SSPINConfirmPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import KeychainAccess

class PINConfirmPresenter: BasePresenter {

    weak var view: PINConfirmViewProtocol?
    private var wireFrame: PINConfirmWireFrameProtocol
    private var interactor: PINConfirmInteractorProtocol

    private var type: PINModuleType
    private var tokens: SignUpPositiveModel
    private var pinToConfirm: String
    
    init(view: PINConfirmViewProtocol, wireFrame: PINConfirmWireFrameProtocol, interactor: PINConfirmInteractorProtocol, type: PINModuleType, tokens: SignUpPositiveModel, pin: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.tokens = tokens
        self.pinToConfirm = pin
    }
    
}

extension PINConfirmPresenter: PINConfirmPresenterProtocol {
    
    func confirmSignUp(code: String) {
        let keychain = Keychain(service: "com.hilton.SecurePlace2")
        
         do {
            try keychain.set(KeychainManager.getHashedPIN(pin: code), key: "pinHash")
            try keychain.set(self.tokens.refresh_token, key: "refreshToken")
            try keychain.set(self.tokens.access_token, key: "accessToken")
         } catch let error {
            self.view?.showOkAlertController(title: "Security error!", message: "Unexpected security error occured! \n \(error.localizedDescription) \n Screenshot this and open support ticket, please!", callback: nil)
            self.view?.hideLoading()
            return
         }

         self.wireFrame.presentAlbumsViewController(from: self.view)
    }
    
    func confirmSignIn(code: String) {
        
    }
    
    func confirmPINChange(code: String) {
        
    }
    
    func didFinishEnteringCode(code: String) {
        
        if(code == self.pinToConfirm) {
            switch type {
                case .signUp:
                    self.confirmSignUp(code: code)
                case .signIn:
                    self.confirmSignIn(code: code)
                case .PINChange:
                    self.confirmPINChange(code: code)
                
                default: break
            }
            
        } else {
            let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.view?.clearPin() })
            self.view?.showAlert(title: "PIN codes are different", message: "Try enter your PIN again", buttons: [actionOk])
        }
        
    }
}
