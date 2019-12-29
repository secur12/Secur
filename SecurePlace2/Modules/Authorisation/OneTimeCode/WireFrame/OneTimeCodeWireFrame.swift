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
    func presentMasterPassword(from view: OneTimeCodeViewProtocol?, type: MasterPasswordModuleType, oneTimeCodeModel: CheckOneTimeCodeModel) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentMasterPasswordViewController()
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
 
    func presentPINSetup(from view: OneTimeCodeViewProtocol?, type: PINModuleType, oneTimeCodeModel: CheckOneTimeCodeModel) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINSetupViewController(type: type, oneTimeCodeModel: oneTimeCodeModel)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
    
}
