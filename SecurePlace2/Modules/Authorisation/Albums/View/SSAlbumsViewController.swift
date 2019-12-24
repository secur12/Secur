//
//  SSAlbumsViewController.swift
//  SecurePlace2
//
//  Created by YY on 25/12/2019.
//  Copyright © 2019 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class AlbumsViewController: BaseViewController {

    var presenter: AlbumsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }
}
extension AlbumsViewController: AlbumsViewProtocol { }
