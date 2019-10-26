//
//  NetworkRequest.swift
//  Parlist
//
//  Created by  Егор on 13.09.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation

enum RequestHTTPMethod {
    case get
    case post
    case put
    case delete
    case multiple
}

protocol NetworkRequest {
    var path: String { get }
    var method: RequestHTTPMethod { get }
    var params: [String: Any] { get }
    var bodyParams: [String: Any] { get }
    //var authorized: Bool { get }
}

//protocol AuthorizedRequest: NetworkRequest { }
//
//extension AuthorizedRequest {
//    var authorized: Bool {
//        return true
//    }
//}
//
//protocol UnauthorizedRequest: NetworkRequest { }
//
//extension UnauthorizedRequest {
//    var authorized: Bool {
//        return false
//    }
//}
