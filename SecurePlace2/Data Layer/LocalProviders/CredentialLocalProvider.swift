//
//  CredentialLocalProvider.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 18/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

protocol CredentialLocalProviderProtocol {
    func getCredential(_ id: Int, completion: ((CredentialModel?, Error?) -> Void)?)
    func getCredentials(_ completion: (([CredentialModel]?, Error?) -> Void)?)
    func deleteCredential(_ credential: CredentialModel, completion: (([CredentialModel]?) -> Void)?)
    func saveCredential(_ credential: CredentialModel, completion: ((CredentialModel?) -> Void)?)
    func editCredential(_ credential: CredentialModel, completion: ((Bool?) -> Void)?)
}

class CredentialLocalProvider {

    private let realmWrapper: RealmWrapper

    init(realmWrapper: RealmWrapper) {
        self.realmWrapper = realmWrapper
    }
}

extension CredentialLocalProvider: CredentialLocalProviderProtocol {

    func getCredential(_ id: Int, completion: ((CredentialModel?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let rlmObject = realm.object(ofType: CredentialRealmModel.self, forPrimaryKey: id)
            completion?(rlmObject?.getModel(), nil)
        }
    }

    func getCredentials(_ completion: (([CredentialModel]?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let allRlmObjects = realm.objects(CredentialRealmModel.self)

            if allRlmObjects.count > 0 {
                var models = [CredentialModel]()
                allRlmObjects.forEach {
                    models.append($0.getModel())
                }
                completion?(models, nil)
            } else {
                completion?(nil, NSError())
            }
        }
    }

    func deleteCredential(_ credential: CredentialModel, completion: (([CredentialModel]?) -> Void)?) {
        var models = [CredentialModel]()
        self.realmWrapper.writeOperationAsync( { (realm) in
            if let rlmObject = realm.object(ofType: CredentialRealmModel.self, forPrimaryKey: credential.id) {
                realm.delete(rlmObject)
            }
            let rlmObjects = realm.objects(CredentialRealmModel.self)
            rlmObjects.forEach {
                models.append($0.getModel())
            }
            completion?(models)
        }, callback: nil)
    }

    func saveCredential(_ credential: CredentialModel, completion: ((CredentialModel?) -> Void)?) {
        self.realmWrapper.writeOperationAsync({ (realm) in
            let realmObject = CredentialRealmModel.convert(from: credential)
            realmObject.id = realmObject.incrementID()
            realm.add(realmObject)
            completion?(realmObject.getModel())
        }, callback: nil)
    }

    func editCredential(_ credential: CredentialModel, completion: ((Bool?) -> Void)?) {
        self.realmWrapper.writeOperationAsync({ (realm) in
            let credentials = realm.objects(CredentialRealmModel.self).filter("id==\(credential.id)")

            if let realmCredential = credentials.first {
                do {
                    realmCredential.serviceLogoImageTitle = credential.serviceLogoImageTitle
                    realmCredential.serviceTitleLabel = credential.serviceTitleLabel
                    realmCredential.usernameLabel = credential.usernameLabel
                    realmCredential.password = credential.password
                    realmCredential.pathUrl = credential.pathUrl
                    completion?(true)
                } catch {
                    completion?(false)
                }
            }

        }, callback: nil)
    }

}
