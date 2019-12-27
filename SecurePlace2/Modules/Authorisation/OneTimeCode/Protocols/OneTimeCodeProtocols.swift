//
//  SSOneTimeCodeProtocols.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

protocol OneTimeCodeViewProtocol: class {
    func showLoading(message: String?)
    func hideLoading()
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func showAlert(title: String?, message: String?, buttons: [UIAlertAction])
    func clearCodeTextField()
    func setDescriptionTextWithEmail(descriptionText: String, email: String, numberOfLines: Int)
}

protocol OneTimeCodeWireFrameProtocol: class { }

protocol OneTimeCodePresenterProtocol: class {
    func setDescriptionText()
    
    func didClickContinue(code: String)
    func checkSignInCode(code: String)
    func checkPINResetCode(code: String)
    func checkColdpassInstallCode(code: String)
}

protocol OneTimeCodeInteractorProtocol: class { }
