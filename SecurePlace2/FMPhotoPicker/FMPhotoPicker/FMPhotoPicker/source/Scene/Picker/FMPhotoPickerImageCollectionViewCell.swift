//
//  FMPhotoPickerImageCollectionViewCell.swift
//  FMPhotoPicker
//
//  Created by c-nguyen on 2018/01/23.
//  Copyright © 2018 Tribal Media House. All rights reserved.
//

import UIKit
import Photos

class FMPhotoPickerImageCollectionViewCell: UICollectionViewCell {
    static let scale: CGFloat = 3
    static let reuseId = String(describing: FMPhotoPickerImageCollectionViewCell.self)
    
    
    @IBOutlet weak var cellFilterContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectedIndex: UILabel!
    @IBOutlet weak var videoInfoView: UIView!
    @IBOutlet weak var videoLengthLabel: UILabel!
    @IBOutlet weak var editedMarkImageView: UIImageView!
    @IBOutlet weak var editedMarkImageViewTopConstraint: NSLayoutConstraint!
    
    weak var photoAsset: FMPhotoAsset?
    
    public var onTapSelect = {}
    
    private var selectMode: FMSelectMode!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellFilterContainer.layer.borderColor = Colors.brandBlue.cgColor
        self.cellFilterContainer.layer.borderWidth = 2
        self.cellFilterContainer.isHidden = true
        self.videoInfoView.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.photoAsset?.cancelAllRequest()
        self.imageView.image = nil
        //self.imageView = nil
        self.photoAsset = nil
                self.videoInfoView.isHidden = true
        
        print("[cell] prepare for reuse")
    }

    deinit {
        print("[cell] deinit")
    }

    public func loadView(isSelectionViewHidden: Bool, photoAsset: FMPhotoAsset, selectMode: FMSelectMode, selectedIndex: Int?) {
        self.selectMode = selectMode
        
   
        if isSelectionViewHidden {
            self.selectedIndex.isHidden = true
            self.selectButton.isHidden = true
            self.editedMarkImageViewTopConstraint.constant = 10
        } else {
            self.selectedIndex.isHidden = false
            self.selectButton.isHidden = false
        }

        self.photoAsset = photoAsset

        photoAsset.requestThumb() { [weak self] image in
            self?.imageView.image = image
        }
        
        photoAsset.thumbChanged = { [weak self, weak photoAsset] image in
            guard let strongSelf = self, let strongPhotoAsset = photoAsset else { return }
            strongSelf.imageView.image = image
            strongSelf.editedMarkImageView.isHidden = !strongPhotoAsset.isEdited()
        }
        
        if photoAsset.mediaType == .video {
            self.videoInfoView.isHidden = false
            
            if let videoURL = photoAsset.encryptedVideoURL {
                if let videoDuration = photoAsset.videoDuration {
                self.videoLengthLabel.text = CMTimeGetSeconds(videoDuration).stringTime
                }
            }
        }
        
        self.editedMarkImageView.isHidden = !photoAsset.isEdited()
        
        self.performSelectionAnimation(selectedIndex: selectedIndex)
    }
    
    @IBAction func onTapSelects(_ sender: Any) {
        self.onTapSelect()
    }

    func performSelectionAnimation(selectedIndex: Int?) {
        if let selectedIndex = selectedIndex {
            if self.selectMode == .multiple {
                self.selectedIndex.isHidden = false
                self.selectedIndex.text = "\(selectedIndex + 1)"
                self.selectButton.setImage(UIImage(named: "check_on", in: Bundle(for: self.classForCoder), compatibleWith: nil), for: .normal)
            } else {
                self.selectedIndex.isHidden = true
                self.selectButton.setImage(UIImage(named: "single_check_on", in: Bundle(for: self.classForCoder), compatibleWith: nil), for: .normal)
            }
            self.cellFilterContainer.isHidden = false
        } else {
            self.selectedIndex.isHidden = true
            self.cellFilterContainer.isHidden = true
            self.selectButton.setImage(UIImage(named: "check_off", in: Bundle(for: self.classForCoder), compatibleWith: nil), for: .normal)
        }
    }
}
