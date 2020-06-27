//
//  SSSSAddCredentialWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

class AddCredentialWireFrame: BaseWireFrame {
    //func presentSomeViewController(from view: AddCredentialViewProtocol) {
    //    guard let fromView = view as? UIViewController else { return }
    //    let viewController = self.resolver.someViewController()
    //    fromView.navigationController?.pushViewController(viewController, animated: true)
    //}
}

extension AddCredentialWireFrame: AddCredentialWireFrameProtocol {

    func presentPasswordGenerator(view: AddCredentialViewProtocol?) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentPasswordGeneratorViewController()
        fromView.navigationController?.pushViewController(viewController, animated: true)
    }
}
