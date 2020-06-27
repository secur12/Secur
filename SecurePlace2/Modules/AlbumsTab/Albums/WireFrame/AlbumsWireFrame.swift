//
//  AlbumsWireFrame.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit

class AlbumsWireFrame: BaseWireFrame {

}

extension AlbumsWireFrame: AlbumsWireFrameProtocol {
    func presentGallery(from view: AlbumsViewProtocol?, model: AlbumModel) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentGalleryViewController(album: model)
        fromView.navigationController?.pushViewController(viewController, animated: true)
    }
}
