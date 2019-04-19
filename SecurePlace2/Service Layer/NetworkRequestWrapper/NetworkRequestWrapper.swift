//
//  MoyaTargetRequestWrapper.swift
//  Parlist
//
//  Created by  Егор on 13.09.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation
import Moya

protocol NetworkRequestWrapperProtocol {
    func runRequest(_ request: NetworkRequest, baseURL: String, authToken: String, progressResult: ((Double) -> Void)?, completion: @escaping(_ statusCode: Int, _ requestData: Data?, _ error: NetworkError?) -> Void)
}

class NetworkRequestWrapper: NetworkRequestWrapperProtocol {
    func runRequest(_ request: NetworkRequest, baseURL: String, authToken: String, progressResult: ((Double) -> Void)?, completion: @escaping(_ statusCode: Int, _ requestData: Data?, _ error: NetworkError?) -> Void) {

        let target = NetworkTarget(request: request, token: authToken, baseURL: baseURL)

        self.runWith(target: target, progressResult: progressResult, completion: { (statusCode, data, error) in
            let body: String? = (data != nil) ? (String.init(data: data!, encoding: .utf8)) : ""
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            print("Request url: \(baseURL + target.path)")
            print("Request headers: \(target.headers ?? [:])")
            print("Request body: \(String(describing: body))")
            print("Request error code \(String(describing: error?.errorCode)) body: \(String(describing: error?.plainBody))")
            print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
            completion(statusCode, data, error)
        })
    }

    private func runWith(target: NetworkTarget, progressResult: ((Double) -> Void)?, completion: @escaping(_ statusCode: Int, _ responseData: Data?, _ error: NetworkError?) -> Void) {

        let requestStartTime = DispatchTime.now()

        let provider = MoyaProvider<NetworkTarget>()
        provider.request(target, progress: { (progressResponse) in

            let progress = progressResponse.progress
            progressResult?(progress)

        }) { (resultResponse) in

            let requestEndTime = DispatchTime.now()
            let requestTime = requestEndTime.uptimeNanoseconds - requestStartTime.uptimeNanoseconds
//            print("Продолжительность запроса: \((Double(requestTime) / 1_000_000_000).round(6)) секунд")

            switch resultResponse {

            case .success(let response):

                if 200...299 ~= response.statusCode {
                    completion(response.statusCode, response.data, nil)
                } else {
                    let networkError = NetworkErrorStruct(statusCode: response.statusCode, data: response.data)
                    completion(response.statusCode, nil, networkError)
                }

                //если отправка не прошла на нашей стороне
            case .failure(let error):
                switch error {
                case .underlying(let nsError as NSError, let response):
                    let networkError = NetworkErrorStruct(statusCode: nsError.code, data: response?.data)
                    completion(nsError.code, nil, networkError)
                default:
                    break
                }
            }
        }
    }
}
