//
//  testProtocols.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit

protocol MailViewProtocol: class {
    func showLoading(message: String?)
    func hideLoading()
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func showAlert(title: String?, message: String?, buttons: [UIAlertAction])
    func clearEmailTextField()
    func setDescriptionTextWithModuleType(text: String, boldText: String, numberOfLines: Int)
}

protocol MailWireFrameProtocol: class {
    func presentPINSetupViewController(from view: MailViewProtocol?, type: PINModuleType, tokens: SignUpPositiveModel)
}

protocol MailPresenterProtocol: class {
    func setDescriptionText()
    
    func didClickContinue(email: String)
    func signUpUser(with email: String)
    func signInUser(with email: String)
    func resetPIN(with email: String)
}

protocol MailInteractorProtocol: class {
    func resetPIN(with email: String)
    func signUpUser(with email: String, completion: @escaping (SignUpPositiveApiResponseModel?, NetworkError?) -> Void)
    func signInUser(with email: String, completion: @escaping (_ mailWasSent: Bool, NetworkError?) -> Void)
}
