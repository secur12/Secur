//
//  AuthorisationInteractor.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 08/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class AuthorisationInteractor: BaseInteractor {
    private let networkController: NetworkRequestProvider
    
    init(networkController: NetworkRequestProvider) {
        self.networkController = networkController
    }
}

extension AuthorisationInteractor: AuthorisationInteractorProtocol { }
