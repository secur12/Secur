//
//  SSSSOneTimeCodeWireFrame.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

class OneTimeCodeWireFrame: BaseWireFrame {
}

extension OneTimeCodeWireFrame: OneTimeCodeWireFrameProtocol {
    func presentMasterPassword(from view: OneTimeCodeViewProtocol?, type: MasterPasswordModuleType, accessToken: String?, refreshToken: String?, decryptKeySalt: String?, decryptKeyIV: String?) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentMasterPasswordViewController(type: type, accessToken: accessToken, refreshToken: refreshToken, decryptKeySalt: decryptKeySalt, decryptKeyIV: decryptKeySalt)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
 
    func presentPINSetupNoKey(from view: OneTimeCodeViewProtocol?, accessToken: String, refreshToken: String) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINSetupSignInNoKeyViewController(accessToken: accessToken, refreshToken: refreshToken)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
    
}
