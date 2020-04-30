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

protocol MediaLocalProviderProtocol {
    func getMediasInAlbum(with id: Int, _ completion: ((_ medias: [MediaModel]?, _ error: Error?) -> Void)?)
    func getMedia(id: Int, _ completion: ((_ media: MediaModel?, _ error: Error?) -> Void)?)
    func deleteMedia(_ media: MediaModel, completion: (([MediaModel]?) -> Void)?)
    func saveMediaModel(_ media: MediaModel, completion: ((MediaModel?) -> Void)?)
    
    func savePhotoFile(name: String, image: UIImage, compressionRate: CGFloat, completion: @escaping(_ fileURL: String?) -> Void)
    func saveVideoFile(name: String, video: AVURLAsset, completion: @escaping(_ videoNameAndExtension: String?, _ thumbnailName: String?) -> Void)
    func loadPhotoWith(fileUrlPath: String, completion: ((UIImage?) -> Void)?)
    func loadVideoWith(fileUrlPath: String, completion: ((URL?) -> Void)?)
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

    func deleteMedia(_ category: MediaModel, completion: (([MediaModel]?) -> Void)?) {
        var models = [MediaModel]()
        self.realmWrapper.writeOperationAsync( { (realm) in
            if let rlmObject = realm.object(ofType: MediaRealmModel.self, forPrimaryKey: category.id) {
                realm.delete(rlmObject)
            }
            let rlmObjects = realm.objects(MediaRealmModel.self).sorted(by: { $0.creationDate > $1.creationDate })
            rlmObjects.forEach {
                models.append($0.getModel())
            }
            completion?(models)
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

    func savePhotoFile(name: String, image: UIImage, compressionRate: CGFloat, completion: @escaping(String?) -> Void) {
        let fileManager = FileManager.default
        if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false) {
            let fileURL = documentDirectory.appendingPathComponent(name)
            if let imageData = image.jpegData(compressionQuality: compressionRate) {
                        do {
                            try imageData.write(to: fileURL)
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

    func saveVideoFile(name: String, video: AVURLAsset, completion: @escaping(_ videoNameAndExtension: String?, _ thumbnailName: String?) -> Void) {
        let fileManager = FileManager.default
        if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false) {
            let fileURL = documentDirectory.appendingPathComponent(name).appendingPathExtension(video.url.absoluteURL.pathExtension)
            if let videoData = try? Data(contentsOf: video.url) {
                        do {
                            let imgGenerator = AVAssetImageGenerator(asset: video)
                            imgGenerator.appliesPreferredTrackTransform = true
                            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                            let thumbnail = UIImage(cgImage: cgImage)
                            savePhotoFile(name: name, image: thumbnail, compressionRate: 0) { (thumbnailPhotoName) in
                                do {
                                    try videoData.write(to: fileURL)
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

    func loadPhotoWith(fileUrlPath: String, completion: ((UIImage?) -> Void)?) {
        guard let imageURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(fileUrlPath) else { return  }
        if let imageData = NSData(contentsOf: imageURL) {
            let image = UIImage(data: imageData as Data)
            completion?(image)
        }
    }

    func loadVideoWith(fileUrlPath: String, completion: ((URL?) -> Void)?) {
        guard let videoURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(fileUrlPath)
            else { return }
        completion?(videoURL)
    }
}

