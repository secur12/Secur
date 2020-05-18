//
//  SSAddCredentialProtocols.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol AddCredentialViewProtocol: class {
    func configure(model: CredentialModel?)
    func showOkAlertController(title: String?, message: String?, callback: (() -> Void)?)
    func popViewController()
}

protocol AddCredentialWireFrameProtocol: class { }

protocol AddCredentialPresenterProtocol: class {
    
    func didClickActionButton(name: String, serviceLogoTitle: String, service: String, username: String, password: String, urlPath: String)
    func didClickEditButton(id: Int, name: String, serviceLogoTitle: String, service: String, username: String, password: String, urlPath: String)
}

protocol AddCredentialInteractorProtocol: class { }
