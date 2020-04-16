//
//  AlbumsViewController.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit
import DKImagePickerController
import AVFoundation
import AVKit

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
    private let plusButton: SSPlusButton = SSPlusButton()
    
    private var albumNameTextField: UITextField?
    
    private let albumCellReuseIdentifier: String = "AlbumCell"
    private var cellIsInEditingMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func createUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Albums"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(self.didClickEditButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add +", style: .plain, target: self, action: #selector(self.didClickPlusButton))

        view.addSubview(topSeparator)
        view.addSubview(myAlbumsLabel)
        view.addSubview(myAlbumsCollectionView)
        view.addSubview(middleSeparator)
        view.addSubview(categoriesLabel)
        view.addSubview(categoriesCollectionView)
        view.addSubview(plusButton)
        
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
        myAlbumsCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20.withRatio(), bottom: 0, right: 20.withRatio())
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
            make.height.equalTo(albumCellSize.height+11.5.withRatio())
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
        categoriesCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20.withRatio(), bottom: 0, right: 20.withRatio())
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
        
        plusButton.addTarget(self, action: #selector(didClickPlusButton), for: .touchUpInside)
        plusButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-17.withRatio() - (tabBarController?.tabBar.frame.size.height.withRatio() ?? -66.withRatio()))
            make.right.equalToSuperview().offset(-17.withRatio())
            make.height.width.equalTo(56.withRatio())
        }
    }
    
    @objc func didClickPlusButton() {
        presenter.didClickPlusButton()
    }
    
    @objc func didClickEditButton() {
        cellIsInEditingMode = true
        myAlbumsCollectionViewLayout.sectionInset = UIEdgeInsets(top: 11.5.withRatio(), left: 20.withRatio(), bottom: 0, right: 20.withRatio())
        DispatchQueue.main.async {
            self.myAlbumsCollectionView.reloadData()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.didClickFinishEditButton))
            self.navigationItem.rightBarButtonItem = nil
            self.plusButton.isHidden = true
        }
    }
    
    @objc func didClickFinishEditButton() {
        cellIsInEditingMode = false
        myAlbumsCollectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20.withRatio(), bottom: 0, right: 20.withRatio())
        DispatchQueue.main.async {
            self.myAlbumsCollectionView.reloadData()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(self.didClickEditButton))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add +", style: .plain, target: self, action: #selector(self.didClickPlusButton))
            self.plusButton.isHidden = false
        }
    }
}

extension AlbumsViewController: AlbumsViewProtocol {
    
    func showAddActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addAlbumButton = UIAlertAction(title: "Album", style: .default) { _ in
            //self.presenter.didClickAddAlbumOnSheet()
        }
        let addPhotoVideoButton = UIAlertAction(title: "Photo/video", style: .default) { _ in

//            
//            let pickerController = DKImagePickerController()
//            pickerController.singleSelect = false
//            pickerController.autoCloseOnSingleSelect = false
//            pickerController.containsGPSInMetadata = true
//            pickerController.allowSwipeToSelect = true
//            pickerController.allowSelectAll = true
//            pickerController.allowsLandscape = true
//            pickerController.showsEmptyAlbums = true
//            pickerController.showsCancelButton = true
//            pickerController.didSelectAssets = { (assets: [DKAsset]) in
//                print("didSelectAssets")
//                print(assets)
//            }
//            self.present(pickerController, animated: true) {}
            
            //self.presenter.didClickPhotoVideoOnSheet()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(addAlbumButton)
        actionSheet.addAction(addPhotoVideoButton)
        actionSheet.addAction(cancelButton)
        self.present(actionSheet, animated: true)
    }
    
    func showAddAlbumAlert() {
        let alertController = UIAlertController(title: "Add album", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            if let albumName = alertController.textFields?[0].text {
                self.presenter.didClickCreateAlbum(named: albumName)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField) -> Void in
             self.albumNameTextField = textField
             self.albumNameTextField?.delegate = self
             self.albumNameTextField?.placeholder = "Album name"
         }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
             self.present(alertController, animated: true)
        }
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
            
            cell?.tag = indexPath.row
            cell?.delegate = self
            if(cellIsInEditingMode) {
                cell?.deleteButton.isHidden = false
            } else {
                cell?.deleteButton.isHidden = true
            }
        } else {
            let model = AlbumModel(albumTitle: "Videos", numberOfItems: "777", backgroundImage: nil, isLocked: false, password: nil)
            cell?.fill(model: model)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectAlbum()
    }
    
}

extension AlbumsViewController: AlbumCellDelegate {
    func didClickDeleteAlbum(tag: Int) {
        print(tag)
    }
}

extension AlbumsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}



