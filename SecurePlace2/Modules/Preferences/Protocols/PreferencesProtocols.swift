//
//  SSPreferencesProtocols.swift
//  SecurePlace2
//
//  Created by YY on 18/05/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit

protocol PreferencesViewProtocol: class { }

protocol PreferencesWireFrameProtocol: class {
    func presentChangeMasterPassword(from view: PreferencesViewProtocol?)
}

protocol PreferencesPresenterProtocol: class {
    func showMasterPasswordChange()
}

protocol PreferencesInteractorProtocol: class { }
