//
//  AlbumsInteractor.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//
import Realm

class AlbumsInteractor: BaseInteractor {

    let dataProvider = AlbumLocalProvider(realmWrapper: RealmWrapper())
}

extension AlbumsInteractor: AlbumsInteractorProtocol {

    func saveAlbum(_ album: AlbumModel, completion: ((AlbumModel?) -> Void)?) {
        self.dataProvider.saveAlbum(album, completion: completion)
    }

    func deleteAlbum(_ album: AlbumModel, completion: (([AlbumModel]?) -> Void)?) {
        self.dataProvider.deleteAlbum(album, completion: completion)
    }

    func getAlbums(_ completion: (([AlbumModel]?, Error?) -> Void)?) {
        self.dataProvider.getAlbums(completion)
    }
}


