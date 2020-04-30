//
//  FMPhotoPickerViewController.swift
//  FMPhotoPicker
//
//  Created by c-nguyen on 2018/01/23.
//  Copyright © 2018 Tribal Media House. All rights reserved.
//

import UIKit
import Photos
import DKImagePickerController
import MBProgressHUD

// MARK: - Delegate protocol
public protocol FMPhotoPickerViewControllerDelegate: class {
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage])
}

public class FMPhotoPickerViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var numberOfSelectedPhotoContainer: UIView!
    @IBOutlet weak var numberOfSelectedPhoto: UILabel!
    @IBOutlet weak var determineButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Public
    public weak var delegate: FMPhotoPickerViewControllerDelegate? = nil
    private var isScrolled = false
    
    // MARK: - Private
    
    // Index of photo that is currently displayed in PhotoPresenterViewController.
    // Track this to calculate the destination frame for dismissal animation
    // from PhotoPresenterViewController to this ViewController
    private var presentedPhotoIndex: Int?

    private let config: FMPhotoPickerConfig
    private var isSelectionViewHidden: Bool = true
    private let plusButton: SSPlusButton = SSPlusButton()
    private var pickerController: DKImagePickerController!
    private var albumModel: AlbumModel
    private let provider = MediaLocalProvider(realmWrapper: RealmWrapper())

    //  The controller for multiple select/deselect
    private lazy var batchSelector: FMPhotoPickerBatchSelector = {
        return FMPhotoPickerBatchSelector(viewController: self, collectionView: self.imageCollectionView, dataSource: self.dataSource)
    }()
    
    private var dataSource: FMPhotosDataSource! {
        didSet {
            if self.config.selectMode == .multiple {
                // Enable batchSelector in multiple selection mode only
                //self.batchSelector.enable()
            }
        }
    }
    
    // MARK: - Init
    public init(config: FMPhotoPickerConfig, albumModel: AlbumModel) {
        self.config = config
        self.albumModel = albumModel
        super.init(nibName: nil, bundle: nil)
        if dataSource == nil {
            self.requestAndFetchAssets()
        }
        //super.init(nibName: "FMPhotoPickerViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        
        //set navigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Choose", style: .plain, target: self, action: #selector(self.chooseButtonPressed(sender:)))
        
        let reuseCellNib = UINib(nibName: "FMPhotoPickerImageCollectionViewCell", bundle: Bundle(for: self.classForCoder))
        self.imageCollectionView.register(reuseCellNib, forCellWithReuseIdentifier: FMPhotoPickerImageCollectionViewCell.reuseId)
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        
        self.numberOfSelectedPhotoContainer.layer.cornerRadius = self.numberOfSelectedPhotoContainer.frame.size.width / 2
        self.numberOfSelectedPhotoContainer.isHidden = true
        
        //self.determineButton.isHidden = true
        
        // set button title
        //        self.cancelButton.setTitle(config.strings["picker_button_cancel"], for: .normal)
        //        self.cancelButton.titleLabel!.font = UIFont.systemFont(ofSize: config.titleFontSize)
        //self.determineButton.setTitle(config.strings["picker_button_select_done"], for: .normal)
        //self.determineButton.titleLabel!.font = UIFont.systemFont(ofSize: config.titleFontSize)
        
        //set title
        self.title = albumModel.albumTitle
        
        //set collectionview
        self.imageCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-17.withRatio() - (tabBarController?.tabBar.frame.size.height.withRatio() ?? -66.withRatio()))
            make.right.equalToSuperview().offset(-17.withRatio())
            make.height.width.equalTo(56.withRatio())
        }
        plusButton.addTarget(self, action: #selector(didClickPlusButton), for: .touchUpInside)
        
        pickerController = DKImagePickerController()
        pickerController.singleSelect = false
        pickerController.autoCloseOnSingleSelect = false
        pickerController.containsGPSInMetadata = true
        pickerController.allowSwipeToSelect = true
        pickerController.allowSelectAll = true
        pickerController.allowsLandscape = true
        pickerController.showsEmptyAlbums = true
        pickerController.showsCancelButton = true
        pickerController.didSelectAssets = { [weak self] (assets: [DKAsset]) in
            self?.showLoading(message: "Processing")
            let forceCropType = self?.config.forceCropEnabled


            for asset in assets {
                if asset.type == .photo {

                    if let phasset = asset.originalAsset {
                        let requestImageOption = PHImageRequestOptions()
                        requestImageOption.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
                        let manager = PHImageManager.default()
                        manager.requestImage(for: phasset, targetSize: PHImageManagerMaximumSize, contentMode:PHImageContentMode.default, options: requestImageOption) { [weak self] (image: UIImage?, _) in

                            if let originalImage = image {
                                let uuid = UUID().uuidString
                                self?.provider.savePhotoFile(name: uuid, image: originalImage, compressionRate: 0) {
                                    [weak self]  (originalImageName) in

                                    self?.provider.savePhotoFile(name: uuid+"_comressed", image: originalImage, compressionRate: 0) {
                                        [weak self]  (compressedImageName) in

                                        if let originalName = originalImageName, let compressedName = compressedImageName {
                                            let mediaModel = MediaModel(
                                                id: 0,
                                                type: "photo",
                                                albumId: self?.albumModel.id ?? 0,
                                                creationDate: Date(),
                                                encryptedFilePath: originalName,
                                                thumbnailName: compressedName,
                                                durationSeconds: nil,
                                                timeScale: nil,
                                                videoPreviewPath: nil)

                                            self?.provider.saveMediaModel(mediaModel) { [weak self] (model) in
                                                if let model = model {
                                                    self?.provider.loadPhotoWith(fileUrlPath: model.fileName) { [weak self] (originalImage) in

                                                        self?.provider.loadPhotoWith(fileUrlPath: model.thumbnailName) { [weak self] (thumbnailImage) in


                                                            let asset = FMPhotoAsset(id: model.id, sourceImage: originalImage ?? UIImage(), thumbnail: thumbnailImage ?? UIImage(), forceCropType: forceCropType as? FMCroppable)
                                                            self?.dataSource.photoAssets.append(asset)
                                                            DispatchQueue.main.async {
                                                                self?.imageCollectionView.reloadWithoutScrolling()
                                                                self?.imageCollectionView.scrollToItem(at: IndexPath(item: (self?.dataSource.photoAssets.count ?? 1)-1, section: 0), at: .bottom, animated: true)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                } else if asset.type == .video {

                    if let phasset = asset.originalAsset {
                        let requestImageOption = PHImageRequestOptions()
                        requestImageOption.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
                        let manager = PHImageManager.default()
                        manager.requestAVAsset(forVideo: phasset, options: nil) { [weak self] (avAsset, audioMix, info) in

                            if let originalVideo = avAsset as? AVURLAsset {
                                self?.provider.saveVideoFile(name: UUID().uuidString, video: originalVideo) {
                                    [weak self] (videoNameAndExtension, thumbnailName) in

                                    if let videoName = videoNameAndExtension {
                                        let mediaModel = MediaModel(
                                            id: 0,
                                            type: "video",
                                            albumId: self?.albumModel.id ?? 0,
                                            creationDate: Date(),
                                            encryptedFilePath: videoName,
                                            thumbnailName: thumbnailName ?? "",
                                            durationSeconds: originalVideo.duration.seconds,
                                            timeScale: originalVideo.duration.timescale,
                                            videoPreviewPath: thumbnailName)

                                        self?.provider.saveMediaModel(mediaModel) { [weak self] (model) in
                                            if let model = model {
                                                self?.provider.loadVideoWith(fileUrlPath: model.fileName) { [weak self] (videoURL) in
                                                    if let videoURL = videoURL {
                                                        self?.provider.loadPhotoWith(fileUrlPath: model.videoPreviewFileName) { [weak self] (image) in
                                                            if let thumbnailImage = image {
                                                                let asset = FMPhotoAsset(id: model.id, sourceVideo: videoURL, videoDuration: CMTimeMakeWithSeconds(model.durationSeconds, preferredTimescale: model.timeScale), thumbnail: thumbnailImage, forceCropType: forceCropType as? FMCroppable)
                                                                self?.dataSource.photoAssets.append(asset)
                                                                DispatchQueue.main.async {
                                                                    self?.imageCollectionView.reloadWithoutScrolling()
                                                                    self?.imageCollectionView.scrollToItem(at: IndexPath(item: (self?.dataSource.photoAssets.count ?? 1)-1, section: 0), at: .bottom, animated: true)
                                                                }

                                                            }
                                                        }
                                                    }
                                                }
                                                self?.fetchPhotos()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self?.hideLoading()
        }
    }

    public func showLoading(message: String?) {
        if let message = message {
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
        } else {
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
        }
    }

    public func hideLoading() {
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
    }
    
    @objc func chooseButtonPressed(sender: UIBarButtonItem) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(self.cancelButtonPressed(sender:)))
        self.isSelectionViewHidden = false
        self.batchSelector.enable()
        DispatchQueue.main.async {
            self.imageCollectionView.reloadWithoutScrolling()
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Choose", style: .plain, target: self, action: #selector(self.chooseButtonPressed(sender:)))
        self.isSelectionViewHidden = true
        self.batchSelector.disable()
        self.dataSource.clearSelectedPhotoIndexes()
        DispatchQueue.main.async {
            self.imageCollectionView.reloadWithoutScrolling()
        }
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Target Actions
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapDetermine(_ sender: Any) {
        processDetermination()
    }
    
    @objc func didClickPlusButton() {
        self.present(self.pickerController, animated: true) {}
    }
    
    // MARK: - Logic
    private func requestAndFetchAssets() {
        if Helper.canAccessPhotoLib() {
            self.fetchPhotos()
        } else {
            Helper.requestAuthorizationForPhotoAccess(authorized: self.fetchPhotos, rejected: Helper.openIphoneSetting)
        }
    }
    
    private func fetchPhotos() {
        let forceCropType = config.forceCropEnabled ? config.availableCrops.first! : nil
        provider.getMediasInAlbum(with: albumModel.id) { [weak self] (mediaModels, error) in
            if let error = error {
                return
            }

            if let mediaModels = mediaModels {
                var mediaArray = [FMPhotoAsset]()
                for model in mediaModels {
                    if model.type == "photo" {
                        self?.provider.loadPhotoWith(fileUrlPath: model.fileName) { [weak self] (originalImage) in
                            self?.provider.loadPhotoWith(fileUrlPath: model.thumbnailName) { [weak self] (thumbnailImage) in
                                let asset = FMPhotoAsset(id: model.id, sourceImage: originalImage ?? UIImage(), thumbnail: thumbnailImage ?? UIImage(), forceCropType: forceCropType)
                                mediaArray.append(asset)
                            }
                        }
                    } else if model.type == "video" {
                        self?.provider.loadVideoWith(fileUrlPath: model.fileName) { [weak self] (videoURL) in
                            if let videoURL = videoURL {
                                self?.provider.loadPhotoWith(fileUrlPath: model.videoPreviewFileName) { [weak self] (image) in
                                    if let thumbnailImage = image {
                                        let asset = FMPhotoAsset(id: model.id, sourceVideo: videoURL, videoDuration: CMTimeMakeWithSeconds(model.durationSeconds, preferredTimescale: model.timeScale), thumbnail: thumbnailImage, forceCropType: forceCropType)
                                        mediaArray.append(asset)
                                    }
                                }
                            }
                        }
                    }
                }
                self?.dataSource = FMPhotosDataSource(photoAssets: mediaArray)
                DispatchQueue.main.async {
                    self?.imageCollectionView.reloadWithoutScrolling()
                }
            }
        }
    }
    
    public func updateControlBar() {
        if self.dataSource.numberOfSelectedPhoto() > 0 {
            //self.determineButton.isHidden = false
            if self.config.selectMode == .multiple {
                self.numberOfSelectedPhotoContainer.isHidden = false
                self.numberOfSelectedPhoto.text = "\(self.dataSource.numberOfSelectedPhoto())"
            }
        } else {
            //self.determineButton.isHidden = true
            self.numberOfSelectedPhotoContainer.isHidden = true
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isScrolled && imageCollectionView.visibleCells.count > 0 {
            isScrolled = true
            let section = 0
            let item = imageCollectionView.numberOfItems(inSection: section) - 1
            let lastIndexPath = IndexPath(item: item, section: section)
            imageCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: false)
        }
    }
    
    private func processDetermination() {
        FMLoadingView.shared.show()
        
        var dict = [Int:UIImage]()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let multiTask = DispatchGroup()
            for (index, element) in self.dataSource.getSelectedPhotos().enumerated() {
                multiTask.enter()
                element.requestFullSizePhoto(cropState: .edited, filterState: .edited) {
                    guard let image = $0 else { return }
                    dict[index] = image
                    multiTask.leave()
                }
            }
            multiTask.wait()
            
            let result = dict.sorted(by: { $0.key < $1.key }).map { $0.value }
            DispatchQueue.main.async {
                FMLoadingView.shared.hide()
                self.delegate?.fmPhotoPickerController(self, didFinishPickingPhotoWith: result)
            }
        }
    }

    deinit {
        print("\n sdfghj")
    }
}

// MARK: - UICollectionViewDataSource
extension FMPhotoPickerViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let total = self.dataSource?.numberOfPhotos {
            return total
        }
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let photoAsset = self.dataSource.photo(atIndex: indexPath.item) else { return }

        let cell = cell as? FMPhotoPickerImageCollectionViewCell

        cell?.loadView(isSelectionViewHidden: self.isSelectionViewHidden, photoAsset: photoAsset,
                       selectMode: self.config.selectMode,
                       selectedIndex: self.dataSource.selectedIndexOfPhoto(atIndex: indexPath.item))
        cell?.onTapSelect = { [unowned self, unowned cell] in
            if let selectedIndex = self.dataSource.selectedIndexOfPhoto(atIndex: indexPath.item) {
                self.dataSource.unsetSeclectedForPhoto(atIndex: indexPath.item)
                cell?.performSelectionAnimation(selectedIndex: nil)
                self.reloadAffectedCellByChangingSelection(changedIndex: selectedIndex)
            } else {
                self.tryToAddPhotoToSelectedList(photoIndex: indexPath.item)
            }
            self.updateControlBar()
        }
    }


    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FMPhotoPickerImageCollectionViewCell.reuseId, for: indexPath) as? FMPhotoPickerImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    /**
     Reload all photocells that behind the deselected photocell
     - parameters:
     - changedIndex: The index of the deselected photocell in the selected list
     */
    public func reloadAffectedCellByChangingSelection(changedIndex: Int) {
        let affectedList = self.dataSource.affectedSelectedIndexs(changedIndex: changedIndex)
        let indexPaths = affectedList.map { return IndexPath(row: $0, section: 0) }
        self.imageCollectionView.reloadItems(at: indexPaths)
    }
    
    /**
     Try to insert the photo at specify index to selectd list.
     In Single selection mode, it will remove all the previous selection and add new photo to the selected list.
     In Multiple selection mode, If the current number of select image/video does not exceed the maximum number specified in the Config,
     the photo will be added to selected list. Otherwise, a warning dialog will be displayed and NOTHING will be added.
     */
    public func tryToAddPhotoToSelectedList(photoIndex index: Int) {
        if self.config.selectMode == .multiple {
            guard let fmMediaType = self.dataSource.mediaTypeForPhoto(atIndex: index) else { return }

            var canBeAdded = true
            
            switch fmMediaType {
            case .image:
                if self.dataSource.countSelectedPhoto(byType: .image) >= self.config.maxImage {
                    canBeAdded = false
                    let warning = FMWarningView.shared
                    warning.message = String(format: config.strings["picker_warning_over_image_select_format"]!, self.config.maxImage)
                    warning.showAndAutoHide()
                }
            case .video:
                if self.dataSource.countSelectedPhoto(byType: .video) >= self.config.maxVideo {
                    canBeAdded = false
                    let warning = FMWarningView.shared
                    warning.message = String(format: config.strings["picker_warning_over_video_select_format"]!, self.config.maxVideo)
                    warning.showAndAutoHide()
                }
            case .unsupported:
                break
            }
            
            if canBeAdded {
                self.dataSource.setSeletedForPhoto(atIndex: index)
                self.imageCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                self.updateControlBar()
            }
        } else {  // single selection mode
            var indexPaths = [IndexPath]()
            self.dataSource.getSelectedPhotos().forEach { [weak self] photo in
                guard let photoIndex = self?.dataSource.index(ofPhoto: photo) else { return }
                indexPaths.append(IndexPath(row: photoIndex, section: 0))
                self?.dataSource.unsetSeclectedForPhoto(atIndex: photoIndex)
            }
            
            self.dataSource.setSeletedForPhoto(atIndex: index)
            indexPaths.append(IndexPath(row: index, section: 0))
            self.imageCollectionView.reloadItems(at: indexPaths)
            self.updateControlBar()
        }
    }

    //    func generateThumbnail(asset: PHAsset) -> UIImage? {
    //        do {
    //            let asset = AVURLAsset(url: path, options: nil)
    //            let imgGenerator = AVAssetImageGenerator(asset: asset)
    //            imgGenerator.appliesPreferredTrackTransform = true
    //            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
    //            let thumbnail = UIImage(cgImage: cgImage)
    //            return thumbnail
    //        } catch let error {
    //            print("*** Error generating thumbnail: \(error.localizedDescription)")
    //            return nil
    //        }
    //    }
}

// MARK: - UICollectionViewDelegate
extension FMPhotoPickerViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FMPhotoPresenterViewController(config: self.config, dataSource: self.dataSource, initialPhotoIndex: indexPath.item, isSelectionViewHidden: self.isSelectionViewHidden)
        
        self.presentedPhotoIndex = indexPath.item
        
        vc.didSelectPhotoHandler = { [weak self] photoIndex in
            self?.tryToAddPhotoToSelectedList(photoIndex: photoIndex)
        }
        vc.didDeselectPhotoHandler = { [weak self] photoIndex in
            if let selectedIndex = self?.dataSource.selectedIndexOfPhoto(atIndex: photoIndex) {
                self?.dataSource.unsetSeclectedForPhoto(atIndex: photoIndex)
                self?.reloadAffectedCellByChangingSelection(changedIndex: selectedIndex)
                self?.imageCollectionView.reloadItems(at: [IndexPath(row: photoIndex, section: 0)])
                self?.updateControlBar()
            }
        }
        vc.didMoveToViewControllerHandler = { [weak self] vc, photoIndex in
            self?.presentedPhotoIndex = photoIndex
        }
        vc.didTapDetermine = {
            self.processDetermination()
        }
        
        vc.view.frame = self.view.frame
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension FMPhotoPickerViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = FMZoomInAnimationController()
        animationController.getOriginFrame = self.getOriginFrameForTransition
        return animationController
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let photoPresenterViewController = dismissed as? FMPhotoPresenterViewController else { return nil }
        let animationController = FMZoomOutAnimationController(interactionController: photoPresenterViewController.swipeInteractionController)
        animationController.getDestFrame = self.getOriginFrameForTransition
        return animationController
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? FMZoomOutAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        
        interactionController.animator = animator
        return interactionController
    }
    
    func getOriginFrameForTransition() -> CGRect {
        guard let presentedPhotoIndex = self.presentedPhotoIndex,
            let cell = self.imageCollectionView.cellForItem(at: IndexPath(row: presentedPhotoIndex, section: 0))
            else {
                return CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.size.width, height: self.view.frame.size.width)
        }
        return cell.convert(cell.bounds, to: self.view)
    }
}
