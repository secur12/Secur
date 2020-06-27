//
//  MediaLocalProviderTests.swift
//  SecurePlace2Tests
//
//  Created by Oleksandr Bambulyak on 30/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//
import XCTest
import AVKit
@testable import SecurePlace2

class MediaLocalProviderTests: XCTestCase {

    var sut: MediaLocalProvider!
    var testMediaModel: MediaModel!

    var aes: AES256Crypter!
    var key: Data!
    var salt: Data!
    var iv: Data!
    var sourceData: Data!
    var password: String!
    var privateKey: Data!
    var testImage: UIImage!

    override func setUp() {
        sut = MediaLocalProvider(realmWrapper: RealmWrapper())
        testMediaModel = MediaModel(id: 0, type: "testType", albumId: 0, creationDate: Date(), encryptedFilePath: "testEncryptedFilePath", thumbnailName: "testThumbnailName", durationSeconds: nil, timeScale: nil, videoPreviewPath: nil, initializationVector: Data(), salt: Data())

        //Encryption setup
        do {
            testImage = UIImage(named: "googleLogo")
            privateKey = "testKey".data(using: .utf8)!
            password = "testPassword"
            sourceData = "testData".data(using: .utf8)!
            iv = AES256Crypter.randomIv()
            salt = AES256Crypter.randomSalt()
            key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: salt)
            aes = try AES256Crypter(key: key, iv: iv)
        } catch {
        }
    }

    func testMediaModelSaving() {
        sut.saveMediaModel(testMediaModel, completion: nil)
        sut.getMedia(id: 0) { (mediaModel, error) in
            if let error = error {
                XCTFail()
            }
            XCTAssertEqual(self.testMediaModel, mediaModel)
        }
    }

    func testMediaDeleting() {
        sut.saveMediaModel(testMediaModel, completion: nil)
        sut.deleteMedia(0, completion: nil)
        sut.getMedia(id: 0) { (mediaModel, error) in
            XCTAssertEqual(nil, mediaModel)
        }
    }

    func testPhotoSaving() {
        sut.savePhotoFile(name: "testPhoto", image: self.testImage, compressionRate: 1, initializationVector: iv, salt: salt, privateKeyDecryptedData: "testKey".data(using: .utf8)!) { (photoFilePath) in
            XCTAssertNotNil(photoFilePath)
        }
    }

    func testPhotoDeleting() {
        sut.savePhotoFile(name: "testPhoto", image: self.testImage, compressionRate: 0.5, initializationVector: iv, salt: salt, privateKeyDecryptedData: "testKey".data(using: .utf8)!) { (photoFilePath) in
            XCTAssertNotNil(photoFilePath)
            self.sut.deletePhoto(named: "testPhoto") { (result) in
                XCTAssertNotNil(result)
                if(!result!) {
                    XCTFail()
                }
            }
        }
    }

    func testPhotoLoading() {
        sut.savePhotoFile(name: "testPhoto", image: self.testImage, compressionRate: 1, initializationVector: iv, salt: salt, privateKeyDecryptedData: "testKey".data(using: .utf8)!) { (photoFilePath) in
            XCTAssertNotNil(photoFilePath)
            self.sut.loadPhotoWith(initializationVector: self.iv, salt: self.salt, privateKeyDecryptedData: self.privateKey, fileUrlPath: "testPhoto") { (image) in
                XCTAssertNotNil(photoFilePath)
            }
        }
    }

    func testVideoSaving() {
        let path = Bundle.main.path(forResource: "merc", ofType:"mp4") ?? ""
        let testVideoUrl = URL(fileURLWithPath: path)
        sut.saveVideoFile(name: "testVideo", video: AVURLAsset(url: testVideoUrl), initializationVector: iv, salt: salt, privateKeyDecryptedData: privateKey, completion: { (videoNameAndExtension, thumbnailName) in
            XCTAssertNotNil(videoNameAndExtension)
            XCTAssertNotNil(thumbnailName)
        })
    }

    func testVideoDeleting() {
        let path = Bundle.main.path(forResource: "merc", ofType:"mp4") ?? ""
        let testVideoUrl = URL(fileURLWithPath: path)
        sut.saveVideoFile(name: "testVideo", video: AVURLAsset(url: testVideoUrl), initializationVector: iv, salt: salt, privateKeyDecryptedData: privateKey, completion: { (videoNameAndExtension, thumbnailName) in
            XCTAssertNotNil(videoNameAndExtension)
            XCTAssertNotNil(thumbnailName)
            self.sut.deleteVideo(named: "testVideo") { (result) in
                XCTAssertNotNil(result)
                if(!result!) {
                    XCTFail()
                }
            }
        })
    }

    func testVideoLoading() {
        let path = Bundle.main.path(forResource: "merc", ofType:"mp4") ?? ""
        let testVideoUrl = URL(fileURLWithPath: path)
        sut.saveVideoFile(name: "testVideo", video: AVURLAsset(url: testVideoUrl), initializationVector: iv, salt: salt, privateKeyDecryptedData: privateKey, completion: { (videoNameAndExtension, thumbnailName) in
            XCTAssertNotNil(videoNameAndExtension)
            XCTAssertNotNil(thumbnailName)
            self.sut.loadVideoWith(initializationVector: self.iv, salt: self.salt, privateKeyDecryptedData: self.privateKey, fileUrlPath: videoNameAndExtension ?? "") { (url) in
                XCTAssertNotNil(url)
            }
        })
    }
}
