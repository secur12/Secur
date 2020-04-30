//
//  AlbumDataProvider.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 26/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation

protocol AlbumLocalProviderProtocol {
    func getAlbums(_ completion: ((_ categorys: [AlbumModel]?, _ error: Error?) -> Void)?)
    func getAlbum(id: Int, _ completion: ((_ categorys: AlbumModel?, _ error: Error?) -> Void)?)
    func deleteAlbum(_ category: AlbumModel, completion: (([AlbumModel]?) -> Void)?)
    func saveAlbum(_ category: AlbumModel, completion: ((AlbumModel?) -> Void)?)
}

class AlbumLocalProvider {

    private let realmWrapper: RealmWrapper

    init(realmWrapper: RealmWrapper) {
        self.realmWrapper = realmWrapper
    }
}

extension AlbumLocalProvider: AlbumLocalProviderProtocol {

    func getAlbums(_ completion: (([AlbumModel]?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let rlmObjects = realm.objects(AlbumRealmModel.self)
            var models = [AlbumModel]()
            rlmObjects.forEach {
                models.append($0.getModel())
            }
            completion?(models, nil)
        }
    }

    func getAlbum(id: Int, _ completion: ((AlbumModel?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let rlmObject = realm.object(ofType: AlbumRealmModel.self, forPrimaryKey: id)
            completion?(rlmObject?.getModel(), nil)
        }
    }

    func deleteAlbum(_ category: AlbumModel, completion: (([AlbumModel]?) -> Void)?) {
        var models = [AlbumModel]()
        self.realmWrapper.writeOperationAsync( { (realm) in
            if let rlmObject = realm.object(ofType: AlbumRealmModel.self, forPrimaryKey: category.id) {
                realm.delete(rlmObject)
            }
            let rlmObjects = realm.objects(AlbumRealmModel.self).sorted(by: { $0.title > $1.title })
            rlmObjects.forEach {
                models.append($0.getModel())
            }
            completion?(models)
        }, callback: nil)
    }

    func saveAlbum(_ category: AlbumModel, completion: ((AlbumModel?) -> Void)?) {
        self.realmWrapper.writeOperationAsync({ (realm) in
            let realmObject = AlbumRealmModel.convert(from: category)
            realmObject.id = realmObject.incrementID()
            realm.add(realmObject)
            completion?(realmObject.getModel())
//            let rlmObject = realm.object(ofType: AlbumRealmModel.self, forPrimaryKey: category.id) ?? AlbumRealmModel()
//            rlmObject.populate(model: category, realm: realm)
//            completion?(rlmObject.getModel())
        }, callback: nil)
    }
}

