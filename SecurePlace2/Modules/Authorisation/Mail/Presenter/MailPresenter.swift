//
//  testPresenter.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation
import UIKit

class MailPresenter: BasePresenter {

    weak var view: MailViewProtocol?
    private var wireFrame: MailWireFrameProtocol
    private var interactor: MailInteractorProtocol
    private var moduleType: EmailModuleType

    init(view: MailViewProtocol, wireFrame: MailWireFrameProtocol, interactor: MailInteractorProtocol, type: EmailModuleType) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.moduleType = type
    }
    
    func getModuleType() -> EmailModuleType {
        return self.moduleType
    }
    
}

extension MailPresenter: MailPresenterProtocol {
    
    func setDescriptionText() {
        switch self.moduleType {
        case .signUp:
            self.view?.setDescriptionTextWithModuleType(text: "Please, enter your email to Sign Up\n No verification required.", boldText: "Sign Up", numberOfLines: 2)
        case .signIn:
            self.view?.setDescriptionTextWithModuleType(text: "Please, enter your email to Sign In\n We will send one-time code.", boldText: "Sign In", numberOfLines: 2)
        case .PINChange:
            self.view?.setDescriptionTextWithModuleType(text: "Please, enter your email to reset PIN\n We will send one-time code.", boldText: "reset PIN", numberOfLines: 2)
        }
    }
    
    func didClickContinue(email: String) {
        if (String.validateEmail(strEmail: email as String)) {
            switch moduleType {
            case .signUp:
                self.signUpUser(with: email)
            case .signIn:
                self.signInUser(with: email)
            case .PINChange:
                self.resetPIN(with: email)
            }
        } else {
            self.view?.clearEmailTextField()
            self.view?.showOkAlertController(title: "Wrong format!", message: "Please enter a valid email adress", callback: nil)
        }
    }
    
    func resetPIN(with email: String) {
        print("Reset PIN code")
    }
    
    func signUpUser(with email: String) {
        self.view?.showLoading(message: "Loading...")
        self.interactor.signUpUser(with: email) { (model, error) in
            defer { self.view?.hideLoading() }
           
            if let error = error {
                print(error.localizedDescription)
                if(error.errorCode == 400) {
                    let actionNo: UIAlertAction = UIAlertAction(title: "No", style: .default, handler: nil)
                    
                    let actionYes: UIAlertAction = UIAlertAction(title: "Yes", style: .cancel, handler: { action in
                        self.signInUser(with: email) })
                    
                    self.view?.showAlert(title: "Dejavue?", message: "User with this email already exists.\n Do you want to Sign In ?", buttons: [actionNo, actionYes])
                    
                } else {
                    self.view?.showOkAlertController(title: "Error", message: "Something went wrong, error \(error.errorCode)", callback: nil)
                }
                return
            }
            
            if let model = model {
                print(model.access_token)
                print(model.refresh_token)
                let tokensModel = SignUpPositiveModel.convert(from: model)
                self.wireFrame.presentPINSetupViewController(from: self.view, type: .signUp, tokens: tokensModel)
            }
        }
        
    }
    
    func signInUser(with email: String) {
        self.view?.showLoading(message: "Loading...")
        self.interactor.signInUser(with: email) { (mailWasSent, error) in
            defer { self.view?.hideLoading() }
            if let error = error {
                print(error.localizedDescription)
                if(error.errorCode == 404) {
                    let actionNo: UIAlertAction = UIAlertAction(title: "No", style: .default, handler: nil)
                    
                    let actionYes: UIAlertAction = UIAlertAction(title: "Yes", style: .cancel, handler: { action in
                    self.signUpUser(with: email) })
                    
                    self.view?.showAlert(title: "Oh no!", message: "User with this email doesn't exists.\n Do you want to Sign Up ?", buttons: [actionNo, actionYes])
                } else {
                    self.view?.showOkAlertController(title: "Error", message: "Something went wrong, error \(error.errorCode)", callback: nil)
                }
                return
            }
            
            if(mailWasSent) {
                
                //self.wireFrame.presentOneTimeCode(type: .signIn)
            }
        }
    }
}
