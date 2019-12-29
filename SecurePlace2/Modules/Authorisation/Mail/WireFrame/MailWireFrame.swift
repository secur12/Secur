//
//  testWireFrame.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit

class MailWireFrame: BaseWireFrame, MailWireFrameProtocol {
    func presentPINSetup(from view: MailViewProtocol?, type: PINModuleType, tokens: SignUpPositiveModel) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINSetupViewController(type: type, signUpModel: tokens)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
  
    func presentOneTimeCode(from view: MailViewProtocol?, type: OneTimeCodeModuleType, email: String) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentOneTimeCodeViewController(type: type, email: email)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
        
}
