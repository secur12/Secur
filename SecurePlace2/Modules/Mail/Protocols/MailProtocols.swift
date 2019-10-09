//
//  testProtocols.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import UIKit

protocol MailViewProtocol: class { }

protocol MailWireFrameProtocol: class { }

protocol MailPresenterProtocol: class {
    func getModuleType() -> EmailModuleType
    
    func signUpUser(with email: String)
    func signInUser(with email: String)
    func resetPIN(with email: String)
}

protocol MailInteractorProtocol: class { }
