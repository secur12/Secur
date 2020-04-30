//
//  MediaRealmModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 21/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MediaRealmModel: Object {

    @objc dynamic var id: Int = Int.min
    @objc dynamic var type: String = ""
    @objc dynamic var albumId: Int = 0
    @objc dynamic var creationDate: Date = Date()
    @objc dynamic var fileName: String = ""
    @objc dynamic var thumbnailName: String = ""
    @objc dynamic var durationSeconds: Double = 0.0
    @objc dynamic var timeScale: Int32 = Int32(0.0)
    @objc dynamic var videoPreviewFileName: String = ""

    override static func primaryKey() -> String? { return #keyPath(MediaRealmModel.id) }

    func getModel() -> MediaModel {
        let model = MediaModel.init(id: self.id,
                                    type: self.type,
                                    albumId: self.albumId,
                                    creationDate: self.creationDate,
                                    encryptedFilePath: self.fileName,
                                    thumbnailName: self.thumbnailName,
                                    durationSeconds: self.durationSeconds,
                                    timeScale: self.timeScale,
                                    videoPreviewPath: self.videoPreviewFileName)
        return model
    }

//    func populate(model: MediaModel, realm: Realm) {
//        self.id = incrementID()
//        self.title = model.albumTitle
//
//        realm.add(self, update: .all)
//    }

    static func convert(from model: MediaModel) -> MediaRealmModel {
        let realmModel = MediaRealmModel()
        realmModel.id = model.id
        realmModel.type = model.type
        realmModel.albumId = model.albumId
        realmModel.creationDate = model.creationDate
        realmModel.fileName = model.fileName
        realmModel.thumbnailName = model.thumbnailName
        realmModel.durationSeconds = model.durationSeconds
        realmModel.timeScale = model.timeScale
        realmModel.videoPreviewFileName = model.videoPreviewFileName

        return realmModel
    }

    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(MediaRealmModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
