//
//  AlbumsLocalProviderTests.swift
//  SecurePlace2Tests
//
//  Created by Oleksandr Bambulyak on 30/05/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//
import XCTest
@testable import SecurePlace2

class AlbumsLocalProviderTests: XCTestCase {

    var sut: AlbumLocalProvider!
    var testAlbumModel: AlbumModel!

    override func setUp() {
        sut = AlbumLocalProvider(realmWrapper: RealmWrapper())
        testAlbumModel = AlbumModel(id: 0, albumTitle: "testTitle", numberOfItems: "", backgroundImage: nil, isLocked: false, password: nil)
    }

    func testAlbumModelSaving () {
        sut.saveAlbum(testAlbumModel, completion: nil)
        sut.getAlbum(id: 0) { (albumModel, error) in
            if let error = error {
                XCTFail()
            }
            XCTAssertEqual(self.testAlbumModel, albumModel)
        }
    }

    func testMediaDeleting () {
        sut.saveAlbum(testAlbumModel, completion: nil)
        sut.deleteAlbum(testAlbumModel, completion: nil)
        sut.getAlbum(id: 0) { (mediaModel, error) in
            XCTAssertEqual(nil, mediaModel)
        }
    }
}
