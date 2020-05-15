//
//  SSPINConfirmPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import KeychainAccess

class PINConfirmSignInWithKeyPresenter: BasePresenter {

    weak var view: PINConfirmViewProtocol?
    private var wireFrame: PINConfirmWireFrameProtocol
    private var interactor: PINConfirmInteractorProtocol
    
    private var accessToken: String
    private var refreshToken: String
    
    private var decryptKeySalt: String
    private var decryptKeyIV: String
    
    private var pinToConfirm: String
    
    init(view: PINConfirmViewProtocol, wireFrame: PINConfirmWireFrameProtocol, interactor: PINConfirmInteractorProtocol, accessToken: String, refreshToken: String, decryptKeySalt: String, decryptKeyIV: String, pin: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.decryptKeySalt = decryptKeySalt
        self.decryptKeyIV = decryptKeyIV
        self.pinToConfirm = pin
    }
    
    private func confirmSignInWithKey(code: String) {
        
    }
}

extension PINConfirmSignInWithKeyPresenter: PINConfirmPresenterProtocol {
    
    func didFinishEnteringCode(code: String) {
         
         if(code == self.pinToConfirm) {
             self.confirmSignInWithKey(code: code)
             
         } else {
             let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                 self.view?.clearPin() })
             self.view?.showAlert(title: "PIN codes are different", message: "Try enter your PIN again", buttons: [actionOk])
         }
     }
}
