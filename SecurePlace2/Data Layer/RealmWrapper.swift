//
//  RealmWrapper.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmWrapper {

    private func getRealm() -> Realm {

        var realm: Realm?
        do {
            try realm = Realm()
        } catch let error {
            debugPrint("Can't create realm: \(error)")
        }
        realm?.autorefresh = false

        return realm!
    }

    func readOperationSync(_ closure: (_ realm: Realm) -> Void) {
        let realm = getRealm()

        closure(realm)
    }

    func writeOperationSync(_ closure: (_ realm: Realm) -> Void) throws {
        let realm = getRealm()

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

    func dropAllData() {
        do {
            try writeOperationSync {
                $0.deleteAll()
            }
        } catch {
            debugPrint("Unavailable to delete all")
        }
    }
}
