//
//  NetworkRequestProvider.swift
//  Parlist
//
//  Created by Emil Karimov on 31.08.2018.
//  Copyright © 2018 ESKARIA Corp. All rights reserved.
//

import Foundation

//protocol NetworkRequestProviderProtocol: NetworkAccountRequestProtocol { }

class NetworkRequestProvider {

    let networkWrapper: NetworkRequestWrapperProtocol
    let tokenRefresher: AuthTokenRefresherProtocol?
    let accountManager: AccountManager

    init(networkWrapper: NetworkRequestWrapperProtocol, tokenRefresher: AuthTokenRefresherProtocol?, accountManager: AccountManager) {
        self.networkWrapper = networkWrapper
        self.tokenRefresher = tokenRefresher
        self.accountManager = accountManager
    }

    internal func runRequest(_ request: NetworkRequest, progressResult: ((Double) -> Void)?, completion: @escaping(_ statusCode: Int, _ requestData: Data?, _ error: NetworkError?) -> Void) {

        let baseUrl = self.accountManager.getBaseUrl()
        let tokenString = "Basic " + accountManager.getUserToken()

        self.networkWrapper.runRequest(request, baseURL: baseUrl, authToken: tokenString, progressResult: progressResult) { [weak self] (statusCode, data, error) in
            guard let s = self else { return }

            guard let error = error else {
                completion(statusCode, data, nil)
                return
            }

            switch error.type {
            case .unauthorized:
                ///----------------TO-DO: нужен ли нам в реквесте параметр authorized???
                if let tokenRefresher = s.tokenRefresher {
                    tokenRefresher.refreshAuthToken(completion: { (error) in
                        if let error = error {
                            completion(statusCode, data, error)
                            return
                        }

                        s.networkWrapper.runRequest(request, baseURL: baseUrl, authToken: tokenString, progressResult: progressResult, completion: completion)
                    })
                    return
                }
            default:
                completion(statusCode, data, error)
            }
        }
    }
}
