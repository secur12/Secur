//
//  NetworkTarget.swift
//  Parlist
//
//  Created by  Егор on 13.09.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation
import Moya

struct NetworkTarget: TargetType {

    let apiRequest: NetworkRequest
    let authToken: String?

    init(request: NetworkRequest, token: String?, baseURL: String) {
        self.apiRequest = request
        self.authToken = token
        self.baseURL = URL(string: baseURL)!
    }

    var baseURL: URL

    var path: String {
        return apiRequest.path
    }

    var method: Moya.Method {
        switch apiRequest.method {
        case .get:
            return .get
        case .post, .multiple:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }

    //для мок реализации запроса в юнит тестах (если потребуется, то поменять)
    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch apiRequest.method {
        case .get:
            return apiRequest.params.isEmpty ? .requestPlain : .requestParameters(parameters: apiRequest.params, encoding: URLEncoding.default)
        case .post, .multiple, .put, .delete:
            return .requestCompositeParameters(bodyParameters: apiRequest.bodyParams, bodyEncoding: JSONEncoding.default, urlParameters: apiRequest.params)
        }
    }

    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json", "ApiVersion": "1.0.0", "Accept-Language": "ru-RU"] // TODO: пробрасывать локализацию
        if let authToken = authToken {
            headers["Authorization"] = authToken
        }
        return headers
    }

    // если выставить эту валидацию, то в "case .success(let response)" попадем лишь в случае статус кода 200...299, во всех остальных случаях сразу попадаем в "case .failure(let error)": то есть попросту не сможем получить информативную ошибку (плюс вместо достоверных статус кодов приходит какая-то хрень)
    //    public var validationType: ValidationType {
    //        return .successCodes
    //    }
}
