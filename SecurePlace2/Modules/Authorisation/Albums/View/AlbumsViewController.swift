//
//  AlbumsViewController.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class AlbumsViewController: BaseViewController {

    var presenter: AlbumsPresenterProtocol!
    
    private var topSeparator: UIView = UIView()
    private var myAlbumsLabel: UILabel = UILabel()
    private var myAlbumsCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    private let myAlbumsCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let middleSeparator: UIView = UIView()
    private let categoriesLabel: UILabel = UILabel()
    private let categoriesCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    private let categoriesCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    private let addButton: SSPlusButton = SSPlusButton()
    
    private let albumCellReuseIdentifier: String = "AlbumCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    private func createUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Albums"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add +", style: .plain, target: self, action: #selector(self.addButtonClicked))

        view.addSubview(topSeparator)
        view.addSubview(myAlbumsLabel)
        view.addSubview(myAlbumsCollectionView)
        view.addSubview(middleSeparator)
        view.addSubview(categoriesLabel)
        view.addSubview(categoriesCollectionView)
        view.addSubview(addButton)
        
        topSeparator.backgroundColor = Colors.lightGrey
        topSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20.withRatio())
            make.height.equalTo(0.3.withRatio())
            make.right.equalToSuperview()
        }
        
        myAlbumsLabel.text = "My albums"
        myAlbumsLabel.font = UIFont.systemFont(ofSize: 19.withRatio(), weight: .semibold)
        myAlbumsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topSeparator.snp.left)
            make.top.equalTo(topSeparator.snp.bottom).offset(8.withRatio())
        }
        
        let albumCellSize = CGSize(width: 140.withRatio(), height: 178.withRatio())
        myAlbumsCollectionViewLayout.scrollDirection = .horizontal
        myAlbumsCollectionViewLayout.itemSize = albumCellSize
        myAlbumsCollectionViewLayout.sectionInset = UIEdgeInsets(top: 9.withRatio(), left: 20.withRatio(), bottom: 15.withRatio(), right: 20.withRatio())
        myAlbumsCollectionViewLayout.minimumLineSpacing = 15.0.withRatio()
        myAlbumsCollectionViewLayout.minimumInteritemSpacing = 20.withRatio()
        myAlbumsCollectionView.setCollectionViewLayout(myAlbumsCollectionViewLayout, animated: true)
        myAlbumsCollectionView.delegate = self
        myAlbumsCollectionView.dataSource = self
        myAlbumsCollectionView.showsHorizontalScrollIndicator = false
        myAlbumsCollectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellReuseIdentifier)
        myAlbumsCollectionView.backgroundColor = UIColor.white
        myAlbumsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(myAlbumsLabel.snp.bottom).offset(9.withRatio())
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(albumCellSize.height)
        }
        
        middleSeparator.backgroundColor = Colors.lightGrey
        middleSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(myAlbumsCollectionView.snp.bottom).offset(15.withRatio())
            make.left.equalToSuperview().offset(20.withRatio())
            make.height.equalTo(0.3.withRatio())
            make.right.equalToSuperview()
        }
        
        categoriesLabel.text = "Categories"
        categoriesLabel.font = UIFont.systemFont(ofSize: 19.withRatio(), weight: .semibold)
        categoriesLabel.snp.makeConstraints { (make) in
            make.left.equalTo(middleSeparator.snp.left)
            make.top.equalTo(middleSeparator.snp.bottom).offset(8.withRatio())
        }
        
        let categoryCellSize = CGSize(width: 140.withRatio(), height: 178.withRatio())
        categoriesCollectionViewLayout.scrollDirection = .horizontal
        categoriesCollectionViewLayout.itemSize = categoryCellSize
        categoriesCollectionViewLayout.sectionInset = UIEdgeInsets(top: 9.withRatio(), left: 20.withRatio(), bottom: 15.withRatio(), right: 20.withRatio())
        categoriesCollectionViewLayout.minimumLineSpacing = 15.0.withRatio()
        categoriesCollectionViewLayout.minimumInteritemSpacing = 20.withRatio()
        categoriesCollectionView.setCollectionViewLayout(categoriesCollectionViewLayout, animated: true)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        categoriesCollectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellReuseIdentifier)
        categoriesCollectionView.backgroundColor = UIColor.white
        categoriesCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(categoriesLabel.snp.bottom).offset(9.withRatio())
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(categoryCellSize.height)
        }
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        addButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-17.withRatio())
            make.right.equalToSuperview().offset(-17.withRatio())
            make.height.width.equalTo(56.withRatio())
        }
    }
    
    @objc func addButtonClicked() {
        presenter.addButtonClicked()
    }
}

extension AlbumsViewController: AlbumsViewProtocol {
    func showAddActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addAlbumButton = UIAlertAction(title: "Album", style: .default) { _ in
        }
        let addPhotoVideoButton = UIAlertAction(title: "Photo/video", style: .default) { _ in
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(addAlbumButton)
        actionSheet.addAction(addPhotoVideoButton)
        actionSheet.addAction(cancelButton)
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myAlbumsCollectionView {
            return 7
        } else {
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellReuseIdentifier, for: indexPath) as? AlbumCell
        
        if collectionView == myAlbumsCollectionView {
           let model = AlbumModel(albumTitle: "Sample", numberOfItems: "538", backgroundImage: UIImage(named: "honolulu"), isLocked: true, password: "111")
          cell?.fill(model: model)
        } else {
            let model = AlbumModel(albumTitle: "Videos", numberOfItems: "777", backgroundImage: nil, isLocked: false, password: nil)
            cell?.fill(model: model)
        }
        
        return cell ?? UICollectionViewCell()
    }
}
