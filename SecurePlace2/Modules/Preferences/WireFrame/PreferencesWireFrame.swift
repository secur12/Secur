//
//  SSSSPreferencesWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

class PreferencesWireFrame: BaseWireFrame {
    //func presentSomeViewController(from view: PreferencesViewProtocol) {
    //    guard let fromView = view as? UIViewController else { return }
    //    let viewController = self.resolver.someViewController()
    //    fromView.navigationController?.pushViewController(viewController, animated: true)
    //}
}

extension PreferencesWireFrame: PreferencesWireFrameProtocol {

    func presentChangeMasterPassword(from view: PreferencesViewProtocol?) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentMasterPasswordViewController(type: .changeTypeOldMasterPassword, oldMasterPassword: nil)
        fromView.navigationController?.pushViewController(viewController, animated: true)
    }
}
