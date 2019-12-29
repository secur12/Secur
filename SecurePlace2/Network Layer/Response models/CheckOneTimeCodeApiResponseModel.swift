//
//  CheckOneTimeModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 28/12/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

struct CheckOneTimeCodeApiResponseModel: Codable {
    let userInstalledColdPass: Bool
    
    let refresh_token: String
    let access_token: String
    
    let decryptKeySalt: String?
    let decryptKeyIV: String?
}
