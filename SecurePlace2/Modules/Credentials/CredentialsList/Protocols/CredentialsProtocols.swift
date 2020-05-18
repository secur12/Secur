//
//  SSCredentialsProtocols.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol CredentialsViewProtocol: class {
    func insertCredentials(models: [CredentialModel])
}

protocol CredentialsWireFrameProtocol: class {
    func presentAddCredentialController(from view: CredentialsViewProtocol?)
    func presentCredentialsDetails(from view: CredentialsViewProtocol?, model: CredentialModel)
}

protocol CredentialsPresenterProtocol: class {

    func didClickAddCredentialsButton()
    func deleteCredential(model: CredentialModel)
    func showCredentialDetailsWith(model: CredentialModel)
    func reloadData()
}

protocol CredentialsInteractorProtocol: class { }
