//
//  SSSSPrivateKeyWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 14/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

class PrivateKeyWireFrame: BaseWireFrame {
}

extension PrivateKeyWireFrame: PrivateKeyWireFrameProtocol {
    
    func switchToTabBar(from view: PrivateKeyViewProtocol?) {
        guard let fromView = view as? UIViewController else { return }
        let startScreenController = BaseTabBarController(resolver: resolver)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = startScreenController
    }
}
