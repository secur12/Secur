//
//  RealmWrapper.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import RealmSwift
import KeychainAccess

public class RealmWrapper {

    private let keychain: Keychain
    private let config: Realm.Configuration
    //private let realm: Realm
    
    init() {
        self.keychain = Keychain(service: "com.secur.SecurInc")
        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let url = documentDirectory.appendingPathComponent("my-new-realm.realm")
        self.config = Realm.Configuration(fileURL: url, encryptionKey: keychain[data: "realmKey"])
    }

    func getRealm() -> Realm? {
        return try? Realm(configuration: config)
    }

    func readOperationSync(_ closure: (_ realm: Realm) -> Void) {
        do {
            let realm = try Realm(configuration: config)
            realm.autorefresh = false
            closure(realm)
        } catch {

        }
    }

    func writeOperationSync(_ closure: (_ realm: Realm) -> Void) throws {

        let realm = try Realm(configuration: config)
        realm.autorefresh = false
        realm.beginWrite()
        closure(realm)
        try realm.commitWrite()

    }

    func readOperationAsync(_ closure: @escaping (_ realm: Realm) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
                    autoreleasepool {
                self.readOperationSync(closure)
           }
        }
    }

    func writeOperationAsync(_ closure: @escaping (_ realm: Realm) -> Void, callback: ((Error?) -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async {
            autoreleasepool {
                var err: Error?
                do {
                    try self.writeOperationSync(closure)
                } catch let error {
                    err = error
                }
                callback?(err)
            }
        }
    }

//    func dropAllData() {
//        do {
//            try writeOperationSync {
//                $0.deleteAll()
//            }
//        } catch {
//            debugPrint("Unavailable to delete all")
//        }
//    }
}
