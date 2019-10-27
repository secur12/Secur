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
    func presentPINConfirmViewController(from view: MailViewProtocol?, type: PINConfirmModuleType, tokens: SignUpPositiveModel, pin: String) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINConfirmViewController(type: type, tokens: tokens, pin: pin)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
}
