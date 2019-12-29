//
//  NetworkAccountManagementRequestProtocol.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 28/12/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

extension NetworkRequestProvider: NetworkAccountRequestProtocol {
    
    func checkOneTimeSignIn(with code: String, completion: @escaping (CheckOneTimeCodeApiResponseModel?, NetworkError?) -> Void) {
    
          let request = CheckOneTimeCodeApiRequest.init(code: code)
          
          self.runRequest(request, progressResult: nil) { (code, data, error) in
              let jsonDecoder = JSONDecoder()
              
              //MOCKUPS STARTS HERE
              //OK (200) - coldpass installed
              completion(CheckOneTimeCodeApiResponseModel(userInstalledColdPass: true, refresh_token: "x", access_token: "x", decryptKeySalt: "x", decryptKeyIV: "x"), nil)
              //OK (200) - coldpass not instaled
              //completion(CheckOneTimeCodeApiResponseModel(userInstalledColdPass: false, refresh_token: "x", access_token: "x", decryptKeySalt: nil, decryptKeyIV: nil), nil)
              //ERROR (404)
              //completion(nil, NetworkErrorStruct(statusCode: 404, data: nil))
              return
              //MOCKUPS ENDS HERE
              
              if let error = error {
                  completion(nil, error)
                  return
              }
              
              guard let data = data else {
                  let error = NetworkErrorStruct(statusCode: code, data: nil)
                  completion(nil, error)
                  return
              }
              
              do {
                  let models = try jsonDecoder.decode(CheckOneTimeCodeApiResponseModel.self, from: data)
                  completion(models, nil)
              } catch {
                  let error = NetworkErrorStruct(error: error as NSError)
                  completion(nil, error)
              }
          }
    }
}
