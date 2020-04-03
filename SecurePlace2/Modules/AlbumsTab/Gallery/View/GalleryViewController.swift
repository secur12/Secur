//
//  SSGalleryViewController.swift
//  SecurePlace2
//
//  Created by YY on 02/04/2020.
//  Copyright © 2020 Security Inc.. All rights reserved.
//

import UIKit
import SnapKit

class GalleryViewController: MediaBrowser {

    var presenter: GalleryPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }

    private func createUI() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
//        navigationBarTranslucent = false
//        navigationBarTextColor = Colors.textBlue
//        toolbarTextColor = UIColor.white
//        displayActionButton = false
//        displayMediaNavigationArrows = false
//        enableSwipeToDismiss = true
//        //displaySelectionButtons = true
//        enableGrid = true
//        startOnGrid = true
        
        
    }
}

extension GalleryViewController: GalleryViewProtocol { }




