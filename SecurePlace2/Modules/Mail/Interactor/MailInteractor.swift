//
//  testInteractor.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

class MailInteractor: BaseInteractor {
    private let networkController: NetworkRequestProvider
    
    init(networkController: NetworkRequestProvider) {
        self.networkController = networkController
    }
}

extension MailInteractor: MailInteractorProtocol { }
