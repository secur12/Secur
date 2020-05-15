//
//  PINConfirmPresenter+SignUp.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import KeychainAccess

class PINConfirmSignUpPresenter: BasePresenter {

    weak var view: PINConfirmViewProtocol?
    private var wireFrame: PINConfirmWireFrameProtocol
    private var interactor: PINConfirmInteractorProtocol
    
    private var accessToken: String
    private var refreshToken: String
    
    private var pinToConfirm: String
    
    init(view: PINConfirmViewProtocol, wireFrame: PINConfirmWireFrameProtocol, interactor: PINConfirmInteractorProtocol, accessToken: String, refreshToken: String, pin: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.pinToConfirm = pin
    }
    
    private func confirmSignUp(code: String) {
        
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

extension PINConfirmSignUpPresenter: PINConfirmPresenterProtocol {

    func didFinishEnteringCode(code: String) {
        
        if(code == self.pinToConfirm) {
            self.confirmSignUp(code: code)
            
        } else {
            let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.view?.clearPin() })
            self.view?.showAlert(title: "PIN codes are different", message: "Try enter your PIN again", buttons: [actionOk])
        }
    }
}
