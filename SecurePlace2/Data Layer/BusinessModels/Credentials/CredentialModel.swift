//
//  File.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 17/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

public struct CredentialModel {

    let id: Int
    let serviceLogoImageTitle: String
    let serviceTitleLabel: String
    let usernameLabel: String
    let password: String
    let pathUrl: String

    init(id: Int, serviceLogoImageTitle: String, serviceTitleLabel: String, usernameLabel: String, password: String, pathUrl: String) {
        self.id = id
        self.serviceLogoImageTitle = serviceLogoImageTitle
        self.serviceTitleLabel = serviceTitleLabel
        self.usernameLabel = usernameLabel
        self.password = password
        self.pathUrl = pathUrl
    }
}

