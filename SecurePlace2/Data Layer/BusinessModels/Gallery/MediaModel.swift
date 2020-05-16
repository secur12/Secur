//
//  MediaModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 26/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//
import Foundation
import UIKit

struct MediaModel {

    let id: Int
    let type: String
    let albumId: Int
    let creationDate: Date
    let fileName: String
    let thumbnailName: String
    let durationSeconds: Double
    let timeScale: Int32
    let videoPreviewFileName: String
    let initializationVector: Data
    let salt: Data


    init(id: Int, type: String, albumId: Int, creationDate: Date, encryptedFilePath: String, thumbnailName: String, durationSeconds: Double?, timeScale: Int32?, videoPreviewPath: String?, initializationVector: Data, salt: Data) {
        self.id = id
        self.type = type
        self.albumId = albumId
        self.creationDate = creationDate
        self.fileName = encryptedFilePath
        self.thumbnailName = thumbnailName
        self.durationSeconds = durationSeconds ?? 0.0
        self.timeScale = timeScale ?? Int32(0.0)
        self.videoPreviewFileName = videoPreviewPath ?? ""
        self.initializationVector = initializationVector
        self.salt = salt
    }
}
