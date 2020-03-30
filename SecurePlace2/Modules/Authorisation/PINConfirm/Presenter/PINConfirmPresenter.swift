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
    
    private var accessToken: String?
    private var refreshToken: String?
    
    private var decryptKeySalt: String?
    private var decryptKeyIV: String?
    
    private var pinToConfirm: String?
    
    init(view: PINConfirmViewProtocol, wireFrame: PINConfirmWireFrameProtocol, interactor: PINConfirmInteractorProtocol, type: PINModuleType, accessToken: String?, refreshToken: String?, decryptKeySalt: String?, decryptKeyIV: String?, pin: String?) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.type = type
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.decryptKeySalt = decryptKeySalt
        self.decryptKeyIV = decryptKeyIV
        self.pinToConfirm = pin
    }
    
}

extension PINConfirmPresenter: PINConfirmPresenterProtocol {
    
    func confirmSignUp(code: String) {
        
    if let accessToken = self.accessToken {
        if let refreshToken = self.refreshToken {
            do {
                let keychain = Keychain(service: "com.hilton.SecurePlace2")
                try keychain.set(KeychainManager.getHashedPIN(pin: code), key: "pinHash")
                try keychain.set(refreshToken, key: "refreshToken")
                try keychain.set(accessToken, key: "accessToken")
                self.wireFrame.presentAlbumsViewController(from: self.view)
        } catch let error {
           self.view?.showOkAlertController(title: "Security error!", message: "Unexpected security error occured! \n \(error.localizedDescription) \n Screenshot this and open support ticket, please!", callback: nil)
           self.view?.hideLoading()
           return
        }
    }
        }
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
