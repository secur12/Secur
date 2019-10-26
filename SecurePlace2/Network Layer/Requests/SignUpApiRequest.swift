//
//  SignUpApiRequest.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 28/09/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

struct SignUpApiRequest: NetworkRequest {
    
    var email: String
    
    var path: String { return "/sign_up/" }
    
    var method: RequestHTTPMethod {
        return .post
    }
    
    var params: [String: Any] {
        return [:]
    }
    
    var bodyParams: [String: Any] {
        return ["email": self.email]
    }
}
