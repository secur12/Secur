//
//  CheckOneTimeCodeModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 29/12/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

class CheckOneTimeCodeModel: Codable {
    let userInstalledColdPass: Bool
    
    let refresh_token: String
    let access_token: String
    
    let decryptKeySalt: String?
    let decryptKeyIV: String?
    
    init(userInstalledColdPass: Bool, refresh_token: String, access_token: String, decryptKeySalt: String?, decryptKeyIV: String?) {
        self.userInstalledColdPass = userInstalledColdPass
        
        self.refresh_token = refresh_token
        self.access_token = access_token
        
        self.decryptKeySalt = decryptKeySalt
        self.decryptKeyIV = decryptKeyIV
    }
    
    static func convert(from model: CheckOneTimeCodeApiResponseModel) -> CheckOneTimeCodeModel {
        let model = CheckOneTimeCodeModel(userInstalledColdPass: model.userInstalledColdPass, refresh_token: model.refresh_token, access_token: model.access_token, decryptKeySalt: model.decryptKeySalt, decryptKeyIV: model.decryptKeyIV)
        return model
    }
}
