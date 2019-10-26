//
//  testWireFrame.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit

class MailWireFrame: BaseWireFrame, MailWireFrameProtocol {
    func presentPINSetupViewController(from view: MailViewProtocol?, type: PINSetupModuleType, tokens: SignUpPositiveModel) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentPINSetupViewController(type: type, tokens: tokens)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
  
    //func presentSomeViewController(from view: testViewProtocol) {
    //    guard let fromView = view as? UIViewController else { return }
    //    let viewController = self.resolver.someViewController()
    //    fromView.navigationController?.pushViewController(viewController, animated: true)
    //}
}
