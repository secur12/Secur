//
//  testInteractor.swift
//  Parlist
//
//  Created by Emil Karimov on 30/09/2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

class MailInteractor: BaseInteractor {
    private let networkController: NetworkAuthRequestProtocol
    
    init(networkController: NetworkAuthRequestProtocol) {
        self.networkController = networkController
    }
}

extension MailInteractor: MailInteractorProtocol {
    func resetPIN(with email: String) {
        
    }
    
    func signUpUser(with email: String, completion: @escaping (SignUpPositiveApiResponseModel?, NetworkError?) -> Void) {
        self.networkController.signUpUser(with: email, completion: completion)
    }
    
    func signInUser(with email: String, completion: @escaping (_ mailWasSent: Bool, NetworkError?) -> Void) {
        self.networkController.signInUser(with: email, completion: completion)
    }
}
