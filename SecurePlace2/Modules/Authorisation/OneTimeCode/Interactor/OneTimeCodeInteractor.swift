//
//  OneTimeCodeInteractor.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambuliak on 19/04/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

class OneTimeCodeInteractor: BaseInteractor {
    
    private let networkController: NetworkRequestProvider
    
    init(networkController: NetworkRequestProvider) {
        self.networkController = networkController
    }
}

extension OneTimeCodeInteractor: OneTimeCodeInteractorProtocol {
    func checkOneTimeSignIn(with code: String, completion: @escaping (CheckOneTimeCodeApiResponseModel?, NetworkError?) -> Void) {
        self.networkController.checkOneTimeSignIn(with: code, completion: completion)
    }
}

