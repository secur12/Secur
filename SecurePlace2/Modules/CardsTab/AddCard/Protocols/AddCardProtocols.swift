//
//  SSAddCardProtocols.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol AddCardViewProtocol: class {
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func configureForEdit(cardNumber: String, expiryDate: String, cvvCode: String, cardHolder: String, type: String, bankName: String, paymentSystemLogoName: String)
    func popViewController()
}

protocol AddCardWireFrameProtocol: class { }

protocol AddCardPresenterProtocol: class {
    func didClickActionButton(cardNumber: String, expiryDate: String, cvvCode: String, cardHolder: String, type: String, bankName: String, paymentSystemString: String)
}

protocol AddCardInteractorProtocol: class { }
