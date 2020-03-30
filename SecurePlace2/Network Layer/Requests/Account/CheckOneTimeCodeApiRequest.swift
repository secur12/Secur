//
//  CheckOneTimeRequest.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 29/12/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

struct CheckOneTimeCodeApiRequest: NetworkRequest {
    
    var code: String
    
    var path: String { return "/check_one_time_code/" }
    
    var method: RequestHTTPMethod {
        return .post
    }
    
    var params: [String: Any] {
        return [:]
    }
    
    var bodyParams: [String: Any] {
        return ["code": self.code]
    }
}
