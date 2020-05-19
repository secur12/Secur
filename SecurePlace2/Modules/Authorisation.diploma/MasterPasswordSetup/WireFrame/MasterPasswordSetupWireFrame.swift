//
//  SSSSMasterPasswordSetupWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

class MasterPasswordSetupWireFrame: BaseWireFrame {
    //func presentSomeViewController(from view: MasterPasswordSetupViewProtocol) {
    //    guard let fromView = view as? UIViewController else { return }
    //    let viewController = self.resolver.someViewController()
    //    fromView.navigationController?.pushViewController(viewController, animated: true)
    //}
}

extension MasterPasswordSetupWireFrame: MasterPasswordSetupWireFrameProtocol {
    func switchToPrivateKey(from view: MasterPasswordSetupViewProtocol?, password: String) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentPrivateKeyViewController(password: password)
        fromView.navigationController?.pushViewController(viewController, animated: true)
    }

    func switchToTabBar(from view: MasterPasswordSetupViewProtocol?) {
        guard let fromView = view as? UIViewController else { return }
        let startScreenController = BaseTabBarController(resolver: resolver)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = startScreenController
    }

    func switchToTypeNewMasterPassword(from view: MasterPasswordSetupViewProtocol?, oldMasterPassword: String) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentMasterPasswordViewController(type: .changeTypeNewMasterPassword, oldMasterPassword: oldMasterPassword)
        fromView.navigationController?.pushViewController(viewController, animated: true)
    }
}
