//
//  AccountManager.swift
//  Parlist
//
//  Created by Emil Karimov on 31.08.2018.
//  Copyright © 2018 ESKARIA Corporation. All rights reserved.
//

import Foundation

struct DefaultsKeys {
    static let app_token = "com.eskaria.parlist.app.token"
    static let user_token = "com.eskaria.parlist.user.token"
    static let refresh_token = "com.eskaria.parlist.user.refresh.token"
}

enum Environmet {
    case develop
    case production
    case local
}

enum GrantType: String {
    case credentials = "client_credentials"
    case password = "password"
}

class AccountManager {

    var environmet: Environmet

    let clientId: String = "parlist_mobile_client"
    let client_secret: String = "75DE815DDC61AB45A5C5C93EF7D9D"

    let appName: String = "parlist_mobile_user"
    let appPassword: String = "38EAAC5D4BF31F5AF846DCEC9D064"

    var isNeedUseAuth: Bool = false

    init(environmet: Environmet) {
        self.environmet = environmet
    }

}

// MARK: - Get constants
extension AccountManager {

    func getBaseUrl() -> String {
        switch environmet {
        case .develop: return "http://127.0.0.1"
        case .production: return "http://api.cherdak.eskaria.com:9090/api/v1"
        case .local: return "http://192.168.100.2:9090/api/v1"
        }
    }

    func getAppToken() -> String {
        return UserDefaults.standard.string(forKey: DefaultsKeys.app_token) ?? ""
    }

    func setAppToken(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: DefaultsKeys.app_token)
    }

    func getUserToken() -> String {
        return UserDefaults.standard.string(forKey: DefaultsKeys.user_token) ?? ""
    }

    func setUserToken(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: DefaultsKeys.user_token)
    }

    func getRefreshToken() -> String {
        return UserDefaults.standard.string(forKey: DefaultsKeys.refresh_token) ?? ""
    }

    func setRefreshToken(newToken: String) {
        UserDefaults.standard.set(newToken, forKey: DefaultsKeys.refresh_token)
    }
}
