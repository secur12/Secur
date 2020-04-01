//
//  ImageCell.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 01/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

protocol CellDelegate: class {
    func cellSelected()
    func cellDeselected()
}

class ImageCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ThumbCell"
    var imageView: UIImageView = UIImageView(frame: .zero)
    var selectedIcon: UIImageView = UIImageView(image: UIImage(named: "selectedArrow"))
    weak var delegate: CellDelegate!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedIcon.isHidden = false
                delegate.cellSelected()
            } else {
                selectedIcon.isHidden = true
                delegate.cellDeselected()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.addSubview(selectedIcon)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        selectedIcon.contentMode = .scaleAspectFit
        selectedIcon.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-7.withRatio())
            make.bottom.equalToSuperview().offset(-7.withRatio())
            make.height.width.equalTo(21.withRatio())
        }
        selectedIcon.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                })
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
}
