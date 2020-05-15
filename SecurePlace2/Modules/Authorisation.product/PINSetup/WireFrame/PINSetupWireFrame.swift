//
//  SSPINSetupWireFrame.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 29/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

class PINSetupWireFrame: BaseWireFrame {
 
}

extension PINSetupWireFrame: PINSetupWireFrameProtocol {

    func presentPINConfirmSignInWithKeyViewController(from view: PINSetupViewProtocol?, accessToken: String, refreshToken: String, decryptKeySalt: String, decryptKeyIV: String, pin: String) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINConfirmSignInWithKeyViewController(accessToken: accessToken, refreshToken: refreshToken, decryptKeySalt: decryptKeySalt, decryptKeyIV: decryptKeyIV, pin: pin)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentPINConfirmSignUpViewController(from view: PINSetupViewProtocol?, accessToken: String, refreshToken: String, pin: String) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINConfirmSignUpViewController(accessToken: accessToken, refreshToken: refreshToken, pin: pin)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentPINConfirmSignInNoKeyViewController(from view: PINSetupViewProtocol?, accessToken: String, refreshToken: String, pin: String) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINConfirmSignInNoKeyViewController(accessToken: accessToken, refreshToken: refreshToken, pin: pin)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
}
