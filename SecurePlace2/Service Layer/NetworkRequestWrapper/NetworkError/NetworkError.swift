//
//  NetworkError.swift
//  Parlist
//
//  Created by  Егор on 13.09.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation

enum NetworkErrorType: Equatable {
    case noConnection
    case lostConnection
    case unauthorized
    case internalServerError
    case badRequest
    case cancelled
    case timedOut
    case notFound
    case forbidden
    case unspecified(statusCode: Int)
}

protocol NetworkError: Error {
    var statusCode: Int { get }
    var type: NetworkErrorType { get }
    var errorCode: Int? { get }
    var description: String? { get }
    var message: String? { get }
    var plainBody: String? { get }
    var detailMessage: String? { get }
}

struct NetworkErrorStruct: NetworkError {

    var statusCode: Int = 0
    var type: NetworkErrorType = .unspecified(statusCode: 0)
    var errorCode: Int?
    var description: String?
    var message: String?
    var plainBody: String?
    var detailMessage: String?
    var userInfo: [String: Any]? //полезно при ошибке JSONDecoder (если неверны ключи), вытащить можно только из NSError

    init(statusCode: Int?, data: Data?) {
        guard let statusCode = statusCode else {
            return
        }

        self.statusCode = statusCode
        self.errorCode = statusCode
        self.setNetworkErrorType(from: statusCode)
        self.parseData(data: data)
    }

    init(error: NSError) {
        self.description = error.localizedDescription
        self.userInfo = error.userInfo
    }

    private mutating func setNetworkErrorType(from statusCode: Int) {
        var networkErrorType: NetworkErrorType

        switch statusCode {
        case URLError.notConnectedToInternet.rawValue, URLError.cannotFindHost.rawValue, URLError.cannotConnectToHost.rawValue:
            networkErrorType = .noConnection
        case URLError.timedOut.rawValue:
            networkErrorType = .timedOut
        case URLError.networkConnectionLost.rawValue:
            networkErrorType = .lostConnection
        case 400:
            networkErrorType = .badRequest
        case 401:
            networkErrorType = .unauthorized
        case 404:
            networkErrorType = .notFound
        case 403:
            networkErrorType = .forbidden
        case 500...599:
            networkErrorType = .internalServerError
        default:
            networkErrorType = .unspecified(statusCode: statusCode)
        }

        self.type = networkErrorType
    }

    private mutating func parseData(data: Data?) {
        guard let data = data else {
            return
        }

        self.plainBody = String.init(data: data, encoding: .utf8)

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

//            self.errorCode = json?["NetworkErrorCode"] as? Int
            self.description = json?["CommonDescription"] as? String
            self.message = json?["reason"] as? String
            self.detailMessage = json?["reason"] as? String

        } catch let error {
            print("Can't parse network error body: \(error)")
        }
    }
}
