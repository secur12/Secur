//
//  NetworkProvider+Auth.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 27/09/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import UIKit

extension NetworkRequestProvider: NetworkAuthRequestProtocol {
    
    func signUpUser(with email: String, completion: @escaping (SignUpPositiveApiResponseModel?, NetworkError?) -> Void) {
        
        let request = SignUpApiRequest.init(email: email)
        
        self.runRequest(request, progressResult: nil) { (_, data, error) in
            let jsonDecoder = JSONDecoder()
            
            //MOCKUPS STARTS HERE
            //OK (200)
            completion(SignUpPositiveApiResponseModel(refresh_token: "xx", access_token: "xx"), nil)
            //USER EXISTS (400)
            //completion(nil, NetworkErrorStruct(statusCode: 400, data: nil))
            //ERROR (404)
            //completion(nil, NetworkErrorStruct(statusCode: 400, data: nil))
            return
            //MOCKUPS ENDS HERE
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NetworkErrorStruct(statusCode: nil, data: nil)
                completion(nil, error)
                return
            }
            
            do {
                let models = try jsonDecoder.decode(SignUpPositiveApiResponseModel.self, from: data)
                completion(models, nil)
            } catch {
                let error = NetworkErrorStruct(error: error as NSError)
                completion(nil, error)
            }
        }
    }
    
    func signInUser(with email: String, completion: @escaping (_ mailWasSent: Bool, NetworkError?) -> Void) {
        
        let request = SignInApiRequest.init(email: email)
        
        self.runRequest(request, progressResult: nil) { (code, _, error) in
            
            //MOCKUPS STARTS HERE
            //OK (200)
            completion(true, nil)
            //USER NOT FOUND (404)
            //completion(false, NetworkErrorStruct(statusCode: 404, data: nil))
            //OTHER ERROR
            //completion(false, NetworkErrorStruct(statusCode: 405, data: nil))
            return
            //MOCKUPS ENDS HERE
            
            if let error = error {
                completion(false, error)
                return
            }
            
            if code==200 {
                completion(true, nil)
                return
            }
            
            completion(false, nil)
        }
    }
    
    

}
