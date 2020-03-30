//
//  SignUpPositiveModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 30/09/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

struct SignUpPositiveModel: Codable {
    let refresh_token: String
    let access_token: String
    
    init(refresh_token: String, access_token: String) {
        self.refresh_token = refresh_token
        self.access_token = access_token
    }
    
    static func convert(from model: SignUpPositiveApiResponseModel) -> SignUpPositiveModel {
        let model = SignUpPositiveModel(refresh_token: model.refresh_token, access_token: model.access_token)
        return model
    }
}
