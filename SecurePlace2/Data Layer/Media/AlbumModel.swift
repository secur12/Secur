//
//  AlbumModel.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 28/03/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

struct AlbumModel {
    let albumTitle: String
    let numberOfItems: String
    let backgroundImage: UIImage?
    let isLocked: Bool
    let password: String?
    
    
    init(albumTitle: String, numberOfItems: String, backgroundImage: UIImage?, isLocked: Bool, password: String?) {
        self.albumTitle = albumTitle
        self.numberOfItems = numberOfItems
        self.backgroundImage = backgroundImage
        self.isLocked = isLocked
        self.password = password
    }
}

