//
//  SignUpPositiveApiResponseModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 28/09/2019.
//  Copyright © 2019 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

struct SignUpPositiveApiResponseModel: Codable {
    let refresh_token: String
    let access_token: String
}
