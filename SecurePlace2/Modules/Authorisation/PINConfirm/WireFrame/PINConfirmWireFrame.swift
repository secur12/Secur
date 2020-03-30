//
//  SSSSPINConfirmWireFrame.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 30/09/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

class PINConfirmWireFrame: BaseWireFrame {

}

extension PINConfirmWireFrame: PINConfirmWireFrameProtocol {
    func presentAlbumsViewController(from view: PINConfirmViewProtocol?) {
        guard let fromView = view as? UIViewController else { return }
        let controller = self.resolver.presentAlbumsViewController()
        fromView.navigationController?.setViewControllers([controller], animated: true)
    }
}
