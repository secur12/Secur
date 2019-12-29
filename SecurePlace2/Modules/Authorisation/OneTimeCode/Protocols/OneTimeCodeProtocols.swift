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

protocol OneTimeCodeWireFrameProtocol: class {
    func presentMasterPassword(from view: OneTimeCodeViewProtocol?, type: MasterPasswordModuleType, oneTimeCodeModel: CheckOneTimeCodeModel)
    func presentPINSetup(from view: OneTimeCodeViewProtocol?, type: PINModuleType, oneTimeCodeModel: CheckOneTimeCodeModel)
}

protocol OneTimeCodePresenterProtocol: class {
    func setDescriptionText()
    
    func didClickContinue(code: String)
    func checkOneTimeSignIn(code: String)
    func checkOneTimePINReset(code: String)
    func checkOneTimeColdpassInstall(code: String)
}

protocol OneTimeCodeInteractorProtocol: class {
    func checkOneTimeSignIn(with code: String, completion: @escaping (CheckOneTimeCodeApiResponseModel?, NetworkError?) -> Void)
}
