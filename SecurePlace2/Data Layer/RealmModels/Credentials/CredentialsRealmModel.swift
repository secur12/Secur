//
//  CredentialsModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 17/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import RealmSwift

class CredentialRealmModel: Object {

    @objc dynamic var id: Int = Int.min
    @objc dynamic var serviceLogoImageTitle: String = ""
    @objc dynamic var serviceTitleLabel: String = ""
    @objc dynamic var usernameLabel: String = ""
    @objc dynamic var password: String = ""

    override static func primaryKey() -> String? { return #keyPath(CredentialRealmModel.id) }

    func getModel() -> CredentialModel {
        let model = CredentialModel(id: self.id, serviceLogoImageTitle: self.serviceLogoImageTitle, serviceTitleLabel: self.serviceTitleLabel, usernameLabel: self.usernameLabel, password: self.password)
        return model
    }

    static func convert(from model: CredentialModel) -> CredentialRealmModel {
        let realmModel = CredentialRealmModel()
        realmModel.id = model.id
        realmModel.serviceLogoImageTitle = model.serviceLogoImageTitle
        realmModel.serviceTitleLabel = model.serviceTitleLabel
        realmModel.usernameLabel = model.usernameLabel
        realmModel.password = model.password

        return realmModel
    }

    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(CredentialRealmModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }

}


