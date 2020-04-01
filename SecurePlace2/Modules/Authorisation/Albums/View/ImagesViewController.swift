//
//  COntrol.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 01/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit
import SwipeSelectingCollectionView

class ImagesViewController: UIViewController {

    var images = [UIImage]()
    
    lazy var layout = GalleryViewLayout()
    
    lazy var collectionView: SwipeSelectingCollectionView = {
        let cv = SwipeSelectingCollectionView(
            frame: .zero, collectionViewLayout: layout)
        cv.register(
            ImageCell.self,
            forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        cv.dataSource = self
        return cv
    }()
    
    override func loadView() {
        super.loadView()
        
        for index in 1...25 {
            images.append(UIImage(named: "honolulu") ?? UIImage())
        }
        
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor
            .constraint(equalTo: view.topAnchor)
            .isActive = true
        collectionView.leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        collectionView.trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        collectionView.bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout(view.frame.size)
    }
    
    private func updateLayout(_ size:CGSize) {
        if size.width > size.height {
            layout.columns = 4
        } else {
            layout.columns = 3
        }
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(size)
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier,
                                 for: indexPath) as! ImageCell
        cell.imageView.image = images[indexPath.item]
        cell.delegate = self

        cell.imageView.setupImageViewer(
            images: images,
            initialIndex: indexPath.item)
        
        return cell
    }
}

extension ImagesViewController: CellDelegate {
    func cellSelected() {
        print("Selected Cel")
    }
    
    func cellDeselected() {
        print("Deselected Cel")
    }
}
