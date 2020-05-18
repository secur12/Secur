//
//  SSSSCredentialsWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

class CredentialsWireFrame: BaseWireFrame {

}

extension CredentialsWireFrame: CredentialsWireFrameProtocol {

    func presentCredentialsDetails(from view: CredentialsViewProtocol?, model: CredentialModel) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentAddCredentialViewController() as? AddCredentialViewController
        viewController?.configure(model: model)
        fromView.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
    }

    func presentAddCredentialController(from view: CredentialsViewProtocol?) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentAddCredentialViewController() as? AddCredentialViewController
        viewController?.configure(model: nil)
        fromView.navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
    }
}
