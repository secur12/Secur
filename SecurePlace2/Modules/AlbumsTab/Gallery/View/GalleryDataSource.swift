//
//  GalleryDataSource.swift
//  SecurePlace2
//
//  Created by Oleksandr Bambulyak on 02/04/2020.
//  Copyright © 2020 Oleksandr Bambulyak. All rights reserved.
//

import Foundation
import UIKit

class GalleryDataSource: NSObject {
    
    private var mediaArray: [Media]!
    private var selections: [Bool]!
    
    override init() {
        mediaArray = [
               Media(image: UIImage(named: "honolulu") ?? UIImage()),
               Media(image: UIImage(named: "p1") ?? UIImage()),
               Media(image: UIImage(named: "p2") ?? UIImage()),
               Media(image: UIImage(named: "p3") ?? UIImage()),
               Media(image: UIImage(named: "p4") ?? UIImage())
           ]
        selections = Array(repeating: false, count: mediaArray.count)
    }
}

extension GalleryDataSource: MediaBrowserDelegate {
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return mediaArray.count
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
          if index < mediaArray.count {
            return mediaArray[index]
          }
        
          let image = UIImage()
          image.withTintColor(UIColor.red)
          return Media(image: image)
    }
    
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> Media {
        if index < mediaArray.count {
          return mediaArray[index]
        }
        
        let image = UIImage()
        image.withTintColor(UIColor.red)
        return Media(image: image)
    }
    
    func mediaDid(selected: Bool, at index: Int, in mediaBrowser: MediaBrowser) {
        selections[index] = selected
    }
    
    func isMediaSelected(at index: Int, in mediaBrowser: MediaBrowser) -> Bool {
        return selections[index]
    }
}
