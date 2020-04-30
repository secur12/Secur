//
//  AlbumsDataSource.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 26/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

protocol AlbumsDataSourceDelegate: class {
    func reloadData()
}

class AlbumsDataSource {

    private var albums = [AlbumModel]()

    weak var delegate: AlbumsDataSourceDelegate?

    func getModelBy(index: Int) -> AlbumModel? {
        return self.albums[index]
    }

    func getNumberOfSections() -> Int {
        return 1
    }

    func getNumberOfItems(in section: Int) -> Int {
        return self.albums.count
    }

    func insertItems(_ items: [AlbumModel]) {
        self.updateWithItems(items)
    }

    func getCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else { return UICollectionViewCell() }
        cell.fill(model: self.albums[indexPath.row])
        return cell
    }

    private func updateWithItems(_ items: [AlbumModel]) {
        self.albums = items
        DispatchQueue.main.async {
           self.delegate?.reloadData()
       }
    }
}

