//
//  SSSSAuthorisationWireFrame.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

class AuthorisationWireFrame: BaseWireFrame, AuthorisationWireFrameProtocol {
    func presentEmail(from view: AuthorisationViewProtocol?, type: EmailConttrollerType) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentMailViewController(type: type)
        fromView.navigationController?.pushViewController(controller, animated: true)
    }
}
