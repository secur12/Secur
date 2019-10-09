//
//  AuthTokenRefresher.swift
//  Parlist
//
//  Created by  Егор on 13.09.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation

protocol AuthTokenRefresherProtocol {
    func refreshAuthToken(completion: @escaping (NetworkError?) -> Void)
}
