//
//  MediaLocalProvider.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 26/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//
import Foundation
import UIKit
import AVKit
import KeychainAccess

protocol MediaLocalProviderProtocol {
    func getMediasInAlbum(with id: Int, _ completion: ((_ medias: [MediaModel]?, _ error: Error?) -> Void)?)
    func getMedia(id: Int, _ completion: ((_ media: MediaModel?, _ error: Error?) -> Void)?)
    func deleteMedia(_ id: Int, completion: ((String?, String?) -> Void)?)
    func saveMediaModel(_ media: MediaModel, completion: ((MediaModel?) -> Void)?)
    
    func savePhotoFile(name: String, image: UIImage, compressionRate: CGFloat, initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, completion: @escaping(_ fileURL: String?) -> Void)
    func saveVideoFile(name: String, video: AVURLAsset, initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, completion: @escaping(_ videoNameAndExtension: String?, _ thumbnailName: String?) -> Void)
    func loadPhotoWith(initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, fileUrlPath: String, completion: ((UIImage?) -> Void)?)
    func loadVideoWith(initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, fileUrlPath: String, completion: ((URL?) -> Void)?)

    func deleteVideo(named: String, completion: @escaping(Bool?) -> Void)
    func deletePhoto(named: String, completion: @escaping(Bool?) -> Void)
}

class MediaLocalProvider {

    private let realmWrapper: RealmWrapper

    init(realmWrapper: RealmWrapper) {
        self.realmWrapper = realmWrapper
    }
}

extension MediaLocalProvider: MediaLocalProviderProtocol {

    func getMediasInAlbum(with id: Int, _ completion: (([MediaModel]?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let rlmObjects = realm.objects(MediaRealmModel.self).filter("albumId == \(id)")
            var models = [MediaModel]()
            rlmObjects.forEach {
                models.append($0.getModel())
            }
            completion?(models, nil)
        }
    }

    func getMedia(id: Int, _ completion: ((MediaModel?, Error?) -> Void)?) {
        self.realmWrapper.readOperationAsync { (realm) in
            let rlmObject = realm.object(ofType: MediaRealmModel.self, forPrimaryKey: id)
            completion?(rlmObject?.getModel(), nil)
        }
    }

     func deleteMedia(_ id: Int, completion: ((String?, String?) -> Void)?) {
        self.realmWrapper.writeOperationAsync( { (realm) in
            if let rlmObject = realm.object(ofType: MediaRealmModel.self, forPrimaryKey: id) {
                let fileName = rlmObject.fileName
                let thumbnailName = rlmObject.thumbnailName
                realm.delete(rlmObject)
                completion?(fileName, thumbnailName)
            } else {
                completion?(nil,nil)
            }
        }, callback: nil)
    }

    func saveMediaModel(_ media: MediaModel, completion: ((MediaModel?) -> Void)?) {
        self.realmWrapper.writeOperationAsync({ (realm) in
            let realmObject = MediaRealmModel.convert(from: media)
            realmObject.id = realmObject.incrementID()
            realm.add(realmObject)
            completion?(realmObject.getModel())
        }, callback: nil)
    }

    func savePhotoFile(name: String, image: UIImage, compressionRate: CGFloat, initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, completion: @escaping(String?) -> Void) {
        let fileManager = FileManager.default
        if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false) {
            let fileURL = documentDirectory.appendingPathComponent(name)
            if let imageData = image.jpegData(compressionQuality: compressionRate) {
                        do {
                            let key = try AES256Crypter.createKey(password: privateKeyDecryptedData, salt: salt)
                            let aes = try AES256Crypter(key: key, iv: initializationVector)
                            let encryptedFileData = try aes.encrypt(imageData)

                            try encryptedFileData.write(to: fileURL)
                            completion(name)
                        } catch {
                            completion(nil)
                        }
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }

    func saveVideoFile(name: String, video: AVURLAsset, initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, completion: @escaping(_ videoNameAndExtension: String?, _ thumbnailName: String?) -> Void) {
        let fileManager = FileManager.default
        if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false) {
            let fileURL = documentDirectory.appendingPathComponent(name).appendingPathExtension(video.url.absoluteURL.pathExtension)
            if let videoData = try? Data(contentsOf: video.url) {
                        do {
                            let imgGenerator = AVAssetImageGenerator(asset: video)
                            imgGenerator.appliesPreferredTrackTransform = true
                            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                            let thumbnail = UIImage(cgImage: cgImage)
                            savePhotoFile(name: name, image: thumbnail, compressionRate: 0, initializationVector: initializationVector, salt: salt, privateKeyDecryptedData: privateKeyDecryptedData) { (thumbnailPhotoName) in
                                do {
                                    let key = try AES256Crypter.createKey(password: privateKeyDecryptedData, salt: salt)
                                    let aes = try AES256Crypter(key: key, iv: initializationVector)
                                    let encryptedFileData = try aes.encrypt(videoData)
                                    
                                    try encryptedFileData.write(to: fileURL)
                                    completion(name+"."+video.url.absoluteURL.pathExtension, thumbnailPhotoName)
                                } catch {
                                    completion(nil, nil)
                                }
                            }
                        } catch {
                            completion(nil, nil)
                        }
            } else {
                completion(nil, nil)
            }
        } else {
            completion(nil, nil)
        }
    }

    func loadPhotoWith(initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, fileUrlPath: String, completion: ((UIImage?) -> Void)?) {
        guard let imageURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(fileUrlPath) else { return  }
        if let encryptedImageData = NSData(contentsOf: imageURL) {
            do {
                let key = try AES256Crypter.createKey(password: privateKeyDecryptedData, salt: salt)
                let aes = try AES256Crypter(key: key, iv: initializationVector)
                let decryptedFileData = try aes.decrypt(encryptedImageData as Data)
                completion?(UIImage(data: decryptedFileData as Data))
            } catch {
                return
            }
        }
    }

    func loadVideoWith(initializationVector: Data, salt: Data, privateKeyDecryptedData: Data, fileUrlPath: String, completion: ((URL?) -> Void)?) {
        guard let encryptedVideoURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(fileUrlPath)
            else { return }

        let decryptedURLPathToWrite = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileUrlPath) as NSURL

        if let encryptedVideoData = NSData(contentsOf: encryptedVideoURL) {
            do {
                let key = try AES256Crypter.createKey(password: privateKeyDecryptedData, salt: salt)
                let aes = try AES256Crypter(key: key, iv: initializationVector)
                let decryptedFileData = try aes.decrypt(encryptedVideoData as Data)
                try decryptedFileData.write(to: decryptedURLPathToWrite as URL)
                completion?(decryptedURLPathToWrite as URL)
            } catch {
                return
            }
        }
    }

    func deleteVideo(named: String, completion: @escaping(Bool?) -> Void) {
//        guard let videoURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(fileUrlPath)
//                  else { return }
//              completion?(videoURL)
    }

    func deletePhoto(named: String, completion: @escaping(Bool?) -> Void) {
        guard let imageURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(named) else { return  }
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: imageURL)
            completion(true)
        } catch {
            completion(false)
        }
    }
}

