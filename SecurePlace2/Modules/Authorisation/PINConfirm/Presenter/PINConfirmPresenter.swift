//
//  SSPINConfirmPresenter.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

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
    
    func didFinishEnteringCode(code: String) {
        
        if(code == self.pinToConfirm) {
            
            switch type {
                
                case .signUp:
                print(1)
                
                default: break
                
            }
            
        } else {
            let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.view?.clearPin() })
            self.view?.showAlert(title: "PIN codes are different", message: "Try enter your PIN again", buttons: [actionOk])
        }
        
    }
}
