//
//  SSCredentialsProtocols.swift
//  SecurePlace2
//
//  Created by YY on 21/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol CredentialsViewProtocol: class { }

protocol CredentialsWireFrameProtocol: class { }

protocol CredentialsPresenterProtocol: class {

    func didClickAddCredentialsButton()
    func deleteCredential(model: CredentialModel)
}

protocol CredentialsInteractorProtocol: class { }
