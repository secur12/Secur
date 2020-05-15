//
//  SSSSCardsWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

class CardsWireFrame: BaseWireFrame {
}

extension CardsWireFrame: CardsWireFrameProtocol {

    func presentAddCardViewController(from view: CardsViewProtocol?) {
         guard let fromView = view as? UIViewController else { return }
         let viewController = self.resolver.presentAddCardViewController()
         fromView.navigationController?.pushViewController(viewController, animated: true)
     }
}
