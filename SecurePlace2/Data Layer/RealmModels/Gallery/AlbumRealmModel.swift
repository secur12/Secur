//
//  AlbumRealmModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AlbumRealmModel: Object {

    @objc dynamic var id: Int = Int.min
    @objc dynamic var title: String = ""

    override static func primaryKey() -> String? { return #keyPath(AlbumRealmModel.id) }

    func getModel() -> AlbumModel {
        //try get last image
        //count number of items
        let model = AlbumModel(id: self.id,
                               albumTitle: self.title,
                               numberOfItems: "",
                               backgroundImage: nil,
                               isLocked: false,
                               password: nil)
        return model
    }

    
    func populate(model: AlbumModel, realm: Realm) {
        self.id = incrementID()
        self.title = model.albumTitle

        realm.add(self, update: .all)
    }
    
    static func convert(from model: AlbumModel) -> AlbumRealmModel {
        let realmModel = AlbumRealmModel()
        realmModel.id = model.id
        realmModel.title = model.albumTitle

        return realmModel
    }

    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(AlbumRealmModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }

}

